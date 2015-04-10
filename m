From: Jim Bos <jim876@xs4all.nl>
Subject: Re: [PATCH] x86/ACPI: Fix regression caused by 16ee7b3dcc56
Date: Fri, 10 Apr 2015 08:19:44 +0200
Message-ID: <55276B80.2010503@xs4all.nl>
References: <55214A0D.9000404@xs4all.nl> <1428417244-32416-1-git-send-email-jiang.liu@linux.intel.com> <55240A82.30101@xs4all.nl> <5524BBEA.5040701@linux.intel.com> <55254E6E.6000705@xs4all.nl> <5526513C.9090200@linux.intel.com> <5526ABA9.1000700@xs4all.nl> <55272DCC.1010900@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040909050301080605050207"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb3-smtp-cloud3.xs4all.net ([194.109.24.30]:39339 "EHLO
	lb3-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097AbbDJGTu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2015 02:19:50 -0400
In-Reply-To: <55272DCC.1010900@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909050301080605050207
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 04/10/2015 03:56 AM, Jiang Liu wrote:
> On 2015/4/10 0:41, Jim Bos wrote:
>> On 04/09/2015 12:15 PM, Jiang Liu wrote:
>>> On 2015/4/8 23:51, Jim Bos wrote:
>>>> On 04/08/2015 07:26 AM, Jiang Liu wrote:
>>>>> On 2015/4/8 0:49, Jim Bos wrote:
>>>>>> On 04/07/2015 04:34 PM, Jiang Liu wrote:
> <snip>
>>> Hi Jim,
>>> 	I'm really confused. I can't even explain why my previous
>>> patch fixes the issue on AMD geode board now:(
>>>
>>> For the Dell laptop, seems you have:
>>> 1) build a kernel with Local APIC and IOAPIC enabled
>>> 2) lapic is disabled by BIOS, so there's no ACPI MADT(APIC)
>>> table at all.
>>> That means the laptop is working with 8259 PICs only.
>>> There's little change between 3.16 and 4.0 related to 8259.
>>>
>>> For the AMD geode board, I still think original code is right.
>>> I can't explain why the patch fix the issue.
>>>
>>> So could you please help to:
>>> 1) Try to enable lapic on Dell laptop in BIOS
>>> 2) Dump acpi tables and dmesg on AMD board
>>>
>>> If that still doesn't help, I will try to send you some
>>> debug patches to gather more info.
>>> Thanks!
>>> Gerry
>>>> _
>>>> Jim
>>>>
>>>
>>
>> Gerry,
>>
>> As you mentioned your patch shouldn't make a difference, run some more
>> tests, as it turns out:
>> - geode system  broken on 3.16+ up to and including 3.19, however, on
>> plain 4.0-rc6 it works!  Root cause appears to be there isn't an ACPI
>> interrupt assigned in non-working kernels.
>> - other system I got my hands on: Pentium(R) CPU G3220, broken on 3.19.0
>> when boot parameter 'nosmp' is specified, again no acpi entry in
>> /proc/interrupts,  working fine on 4.0-rc6
>>
>> So obviously between 3.19 and 4.0-rc6 something got fixed here!
> Hi Jim,
> Yes, the bugfix patch should be:
> commit 1ea76fbadd66("x86/irq: Fix regression caused by commit b568b8601f05")
> 
>> The Dell laptop remains the only problem then on 4.0-rc6, there IS an
>> acpi interrupt  (but firing once apparently).
>> There isn't an option in BIOS to enable LAPIC, however, when specifying
>> 'lapic' as boot parameter I got interesting result, still not working
>> and /proc/interrups still shows XT-PIC.  Doing a diff between dmesg on
>> 3.19 and 4.0-rc6 this pops out:
>>
>> -Local APIC disabled by BIOS -- you can enable it with "lapic"
>> -APIC: disable apic facility
>> -APIC: switched to apic NOOP
>> +Local APIC disabled by BIOS -- reenabling.
>> +Found and enabled local APIC!
>>
>> +Enabling APIC mode:  Flat.  Using 0 I/O APICs
> What's the last know working kernel for Dell laptop?
> Does it work as expected with v3.19 kernel?
> Do you means this message is from plain v4.0-rc6 kernel?
> Thanks!
> Gerry
> 
>>
>> Jim
>>
> 
Last know working version on the Dell laptop is 3.16 and yes this message"

>> -Local APIC disabled by BIOS -- you can enable it with "lapic"
>> -APIC: disable apic facility
>> -APIC: switched to apic NOOP
>> +Local APIC disabled by BIOS -- reenabling.
>> +Found and enabled local APIC!

is from the v4.0-rc6 message. Full dmesg attached.

Jim.



--------------040909050301080605050207
Content-Type: application/x-gzip;
 name="dmesg-lapic_specified.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-lapic_specified.gz"

H4sICChrJ1UAA2RtZXNnLWxhcGljX3NwZWNpZmllZADUXG134sqR/q5fUcn9sHYCWC0JCcg6
JzYvMxwbmxhPbnZnfXyE1ALFgHQl4Zf767eqW0ICJIw9c/ZkOcm1pK6nqrq7qrr6ba791foV
nnkU+8EKjIbaUOuRY/4ZTqIgSP72EofRy+IUTmaOU6BqNQw4+dLtnsIp/MIsuJ+v4SKMoA3M
6mjNjq5Ctz+5B01lTaXnx/Z0wV3w7DiBOIn81QyCkEd2gtxihbc0tQOXw9tJPYyCZ99F0nD+
FvuOvYC7ixEs7bCjiHJJ+n3Jl6C+qju/+tanNvc87wHWQvZhdNvbR3sCHfGYR8/cPYhnu9IN
z7Pd46QTKd9De0dL97hr70jHTx/Ae9Nd7b19+TdB4ju8Azf/hJP+K3fWCYe0V08B+yzhDnUl
LP04ps71V9Adf/uDMhmRZNAaOlIhs1XSUHqjYQd6fLGAbrAMkVOED1EYSGuAa/yTrF3kb6oq
7P/O1C9N1tRqwl7ggpmgmmda+0xT1WZqSevQtVHBnZpmNSz0C5yf/zWvpARHfBk8F8GF5k2b
Je1USb9Am34MvRWcI7noTTTX10c7cuabz9JAlNH93R243LPXiwSStxAbdL1ybGcu2IlSz39F
44/s1YzHwFfCbToKgKxBe4A/eIn8hNentvOEBRei4FIUFJgBdEVBt4BI+wnLeqKsvw8aiIJB
CUho92xHvmi3EgVhasccNj6BjRA/waCbvW4pzVJiY5t4UEqspcSDfu+iSDwY9AvEyTwK1rM5
0uvgpvEGX4ziS7P4YhZfrPxlfHEPqwDD1DpEm0ywN6ZvZMwNxV/5iY8RCS0jiN4oKIVY9zIz
Y1NpKcolaZ7SJ5G9DIOFv+JgJ/DdwRhDrvcA4g/E/u8cmKm3DCHoUaIeSQp6VKmYzCCVQ4UQ
2jMOxtNBrrq1AeqWvsO1rDDlOnpH101k1E1vT9dC2NR3dM2JjD0OR4nWrRxoWZ67U6H9wo3o
y7sr+E59aGkYUtQapM+CaPzl/uLyuq9cdMcYxPp2tMB+FR7hzLnzFK+XNEb6Ho5cIphtrEoC
7ia9seymQQ+NXXgLw4H0GZ97/etrgNOc8p7iyUA6haDUukTJUkq0SR/uKCJqVq+pmqwHF5Pr
NFLga8ZpgH8yTkbKyTI+w6lX0KkrOGl9diE5DW/uDRzzJ/81GfDX11dZM/wfjCYDBMmu7hd0
mqScBq1UJ0NNCy8mgz9kYrLC5iWKwVB/rMJ6m40u4evwy9dRfwT2s+0vqB8aSqtlYcH17a87
3yF1Z1gELxjdlh0MaHUg66DBGYvLvxeMRS8Yi75lLP8drLKISZGyN7qQI1lJFsPUnTxk4zVw
E0RLDD77MFb0efErWDx89WfzEQJ2YVkVyrIWZRQ8C6P+nTSPEztKwAsi4DhQYGx0uSItPw1s
9CWtHwoUb9gXpVnaXv3SLO0wrjq/UoYYA4g85sk6lDzUIwTnDG5XGSoJEntBUSDugK5ZTexe
L+IcR3JuP4pYQ4SdlLwG4QyzDHCYabptx6iJ7xSOKBaBZ7rYvJqa9jc1JHEVUSbGBIKSYWxR
JEfqLSI1pdmkJVsc2u2WLK/B9XBwi0Nj4sw7am4fko5ZhlEpa4tS03Q03RKeOitYT8oVPd7S
ymm/ibzvYjzsghv5GASzRCf16vGofu8v8fPwFsY4rmJFX1tqS7kOKMmXuGyagAOuSO7qdWwF
kWMg74YyCNYrF2z8f5p3oFNm4D8o4xFGTT7zY0wosWgVxPZzNvZWjJ4yFzwaWZglyNnB0ci9
FFLZysWbuVaYu6czj01wEp037g6xQZ8xCY+V0AnXdXuBle9ArEKkgov2arZgLf+IonP2J/G2
Rf0dsw0VlMu1jwkoE726QOVjytdFlAoil0c1WAZTf+EnbzDDpCoUs7VVA+CePAQ2LtK0NEO5
4hEyASdA48KeofQGc+gAaPJ4foYqn8XulInXF9tPIHT8cxsnCbNVfbqOYzTQhR36Dlze3t4/
DkcXX/rnZ1MkPnteIq/176CMhz2Y2/E8HWhxDhH5pIChtk04ERqjGddk7oS2k/D4VOkR2RtQ
astL0UxnKtpyhrdq0NQMrdXKGAzJnevVeLPZ1HPxZg00U2OGkcNFruj/To2H2eMv6vanzLGo
b9P4c5JF5U4aoPgOmywq72DEr5M9nCqj1PyY1sZ5knp1RlXF31XBpE4MnbEreMo6z+U16tAr
iF4wqNnYmG3TwLdAvulN8wooBOIjMZrG6P+sZbTwOYtTOPZdgbO06/kHA8Nuq3UFc6wsWvqp
8uxHyRpNKJWbjh8L+y1YJzQ0As1/KHwChQd0A5tGVRxwxYtH/oc0J6CjlT9dngpE+CQAKaIl
GiFFOPIFEcJWMsTzUriDRFieGAZThBwThQymqTBKETj4k6cKhJM2tERYBQTmFhsEQIPaSyKY
aZkZAl+cvB7NXCtEUGOnCEM3VaxkirAMsyUQmta2ioiEv2YyClpt4CA6WhOILiWoYm7uQTL3
Y5q2YzSJ0ZjmwSpYRzF+5vDrGKaoN3/mK4oKOAvCzvSJaolW0mg0bp8ays3d4/Du75MOjhwG
rKJHP/ot7uDoxkwFbR3tkj4kOH1DM5nbkXvuof6iCeLAS8QbdZTSDVZxsMCA4QQL1AD+8eXi
z9BSX7Wm4sgi+J4kbxi10oivJDGGsQEtI91PuujeC3+arhusxQA0Ht5Lmh6naSsGZWa1jQYN
caOvv+d1VroZFEEuRxPETg5COImffMoDT2s42V2sOYlw1gubOEkJiRjFMDP4bc1Xzlujgb3Y
ajewXy6DWTAajidwsgj/dd5st1TLNE+V0HcxJXjtZAOiyC6wc5ZoIMs1ZpS6ytJBshtEmElh
mBerbLR2himEkeXFCxzq8AnuqSli7BqH6uKtF5iK2c5vaz/aTDQwHRI161937zCxAWSDwcKL
AhxuWiJI4FiaHAhvKLa1iW6sBi3W1rLYJrBh4H+awXvrgUtaaiJDSufgMc7cR90+Jhurp5gs
DIfO+zkXWcwyQDcLBIcsKzi5H2mnyjXxXqAdL8C/v74sjBtXl+jcLYzYOBPAPM7AP1qR3H2X
HN/YF3wjXTowXCV8cXJ3CmME+eslPY4K7sUaLfULGt+JJ+YPZk240gIfMUZi6pDOXFW0lTGP
PMrOVg6HPrpgggqEJiZP39KsqqGgC2brsJ3dtTFVlJL/vvhuMt8p1zVRPOMrnKI6aGcycYlT
MlkqrZ6WWLbR2fiSLQ4KYjRrwG7zA7ec2CoSi6WteriOwiDmIsAkQrRUWrwfkJv+dKWf5oMy
Z1yKlBwG6KGYoMgkVIXh2a0ojhVMQJJl6KEgPxtKaTmzf7+VuNEiV4AxCA1y6aM3YRzDrMl3
KTRJr58F2OYr7MyF7aJJVxYv+Wqd+iCmN2KRT+Ru0UaYgq8d8U3kuLm3N5gKMmvBaQUOLU7b
xFGZlheJ1bkmgbKKGB09f7ZOQ5+QwkReIJbKbBEYsrDh0nL64+1keDIK3DX6aE/kkaf75eON
yVaS6A0VHifdMfRfE74ixeODjC5mM6y6nezxJKeJwojT8m8W3EV06786PEyEdV/0H28wKxzc
frvp1eDXuU8BhgxUhu3JgvMQJolY6/2fx4n2+IAjZBo0z+Yvr57t8HqzpWYyTzbxZKLChMFE
h4kBk2ZW/i0dQrqiKX3SMFqHCaZBaxIoO2A4W8lwMw+oZyLfnXF0t5UbvMQgIiwx+wsNsytO
rWBHbzWahcEfKffFh0cniv8o5jERJ3XAxg6eKbYT+jC+Gatd1sR0riODvRs4TzQFFx19Qm/x
2dR+i9EEMApjaM2UJ4u6w8QZLqVK3/EDDpwIWdo4kIvk4DvZJM4zcH5xmsu7UHUhD7uu2wG0
yU0zfZ/w2ZL89KGcGv3FFxG32FOnf0lncsJJJ+PRPna/6eC7H0A6QaOJkuNZaQlWwacmxzH5
Q4xcOZ/C32cZlU3fpj+FoZszdH+cYcn08ccYepxvGHq2V8FQeAPN60BaVRYLsw0OnAdgTkcT
1j3RZDaUlmAshdGoe3szGH5BfxNDHxl6DdOu1X8kaSADTrGGggvZ+Hboi0P0cVhjaSSzWlmh
Bmm3VUOUJtUUcyWcFfuPhfdCRTK1i85yFPmWActZ/jGwvYWJzfYbwTdQVW3QggEmzmZH1w30
bBH10akdHCJiYkEJtloCwgAs9qA26w08F8bTIZq253Ylsi2JLJPIihKNHYnMzUGa4Wglajqq
XgqSaoplEdmUU5zN1elPe0czST95wwF1CS/2E1+HW4tHFBB3AayglXGsVqxUK0Nq1dzXin1U
K62glXWsVlqpVprUSt/XSvuoVlZBK7dcK21PK6vE0DzaynakVRtlVi1x41H/l8J+mxhEeyr0
9Dl6S0/HxMwtQX2kTrxolUbrOFPmH7Uyb8v2nVIXZbtSBIgmb0+bzqQpGo0OLct7ICzOOIXE
YferIcSefRkPb8/uu7dHsGpJVtMSVsRll0PRT+ySGjCVtewSUKHvU8nMk3uhnvVQTW/k9Lpn
1MWfQ/StAn9L8rcO0TsF/pbkf4h+y6Ns6VH2rs0W6Y3KpWV9z9YFboHZsIPt3+tnPfXRlqvk
sNWW5oegRzdrJYetht4X3iyYVbPErIwyx2iWNM5U+sa0VdK8zZKmmDoyXDvWIfrWdshq5SGr
fVCOs40zcpxRjvtwqPMaZqHpzJKms/bHCAHabzqp3rRMNbOs6VQ5/qrl9J+rytHxlGUpD+06
dbDqZXXXd1KeDLSf8rTylMerSHl2wHlDOBLo7DTEDn3BhhyxVC1swdkf9rZx+v6Opwwh7KCS
mzlaj0FPK0ncKAHOc1+ZzLL6XlopaKF8DpXVez8ZLUdltd/UwnNLU9lD6IMdVUimmVhgWT1G
tEZXqB3gTAFwHiDPgLli8ZMVxGsbszK40WFmsyzB0XbMSqsyK5odZXW1U21NY+onDyXoUocp
9xYty76ZxqyOxZieaakVkwlrV0tWquXu0LTTIxmu0qQygiqPJ/KDNWGfqQn7ZE3YezVhn66J
nid4hqaVzcG01p7l6FWWw72N5fBdL8lwHw6yvMr3NeEdJ/F6mkS2k/jPHGfqtPN3WsKgIiC4
uWM+HINKq2rmAWFaOgs4JDNDej+ifvUk+z2Wme2nDLdXH/zVs73wXTjJ1gpU9eG0hp2dkdGq
4b71/RCvQgzU92OgXhUDzR2stY+1qrD2Dlbbx2rHYrEpsbI330YX6R52YflyuFlxvfZXT/D9
+ubqAjtoePf3mA6Wq/AntrXcWUJ/mdE3wTol+sPk3Q+y7xXYH4vpZxgdDMSZGZIxYBowA1gT
NVVrm2SocZjf1wp+fyoyzE4opltiGs71+uKYx3RBC8oqHXcCNlCeZ7YdTfMNQzsGOn2RnjUR
OnSKiccGIAloBY/OwO6S1aQjxed+8Gf0vVrwsto8kwLx+SpY8Q2zRWAjm81r7h9JFCwgDOLY
p83FLUUm3ckQI+M0lgllcXtn4U9pJz27rYCBVE1FNHb3Zr5NLot7M+t46gQR7xS+wYq/yL0A
2k7IDjchoRcfTz5fTyuJ05bMGSthGD9K0mu6nDEeT2g3i+rTAFZUNyecBF7yYkdcEjUbesOE
OnSD8C3yZ/ME6HR8Hf9jwV3gBgsvgC9+sKROh/+cpU9/owM3rw0/+asyvh/jmCa2HuTYU5R6
4T7TBqUrtUPRdCzrInLmPm25r1GJnqzLMO+TRnH3Smxs0BYLmvH25grFCrGn/EgHiR7FmWg0
TTJWMz1bszmmL06ZiOsh07XnobhDJ7XeAxWuYWyuXyiTFz9BXUQgE62RrtliOoraufV/+Z7n
04GsVYgusBrLipElKqlVphGvNHtp02D4QPs4C1ecOJ/y/NBfFb6dLqdtavZBvJPLdz6D5zne
+wR+c5ITG5l/GG94m2w7vyMzp5DF+eodbOGeTH4/5lhsfkfGSzOY97HjxXomNvnGdLhE7uUJ
T6/BsBeL7RBHZXAiM49TMiJIJzb59tnugqDafEChjk3biX4CtOu8sMN8bKUlQLi8uMMxoWQt
8T0ZLSnD+yEZhVZg+ZqQ4QoKw2XvtBz7fMtp5bUyZa2sn9Jy5TKYJGz+WMsdlmHmS8I/p3e0
Te/k61b8nd7JMVsLy0djHIlxP4LhEnNUrNA+bz36UVCP6ftQ4yiorpZAm0dBp3R6K4MWqmvm
zdSWndy23mta8/NNZB0FbZZBaXHMXdrAHoqfjuBm7HDLB9oOphCUebQ3B6OxhM7UdKC3s6xI
nCpHc9qdfgyXpQsp8ff2w3k2ehn56K0XV6ZgxhOaCz1iMixTls1DCild2vj5vLPpb/nkt1JE
YYlAtR9yAa1KAT+ufDVvil3tDsgz4thb+4ccmtV71nKTglg0S1jkS4viUS9fliW0uY8uLms6
FYuzB9de/z8vvP5fOUbKm6mHmP/7OFyR90/XOW0LC9lmW3Np6n2YHatk1foJrNjP04r9PK1S
t1VL3DY3a/FYsfZ9RNTR33EKYsFKNGjmbtn09t0ya4oK/c1cA/F4AF2mf26JlVGzyKJMfzPn
YVoV+qfVt4rorSVjV61GtUpQMiN1jeralsmSma7bqkaVyZIzatcp17BrR+7lOt6L53pdNcvo
Dy+dV7VDFepAO1SH8o9YbRWL44y2qnEsyiRK6KuqebjjqlAHOq4M9XGXqGDxjkcc3oXZbph/
qw2XIzKtneOM2SlG48jjjxl9871zj9s7vRucWpUhVdCz93KjCpz20e1orUzJ3d6roGfv9VsF
Tvtoj2kf7DHtkz2mH2iMTQCsoGdVoa+CvrQR9oJeBVh/L9xtb5iVVGoncFXQs6qQVUGvHRWs
KsD6wTD13tUXTbnvjoHHdJ3Lj2m6XHa7S9zmym536bX0Rlt6vYsYTDGkfArZga8bVLzZIqU7
BkWd5G0ykkFPKTDiq6C4T/GtNy5Vocm0qptpCKlf+0n5lbYDuHcvFCl34+72XXGbTmJ+uxn+
E+LAeaI9jshexWKvZSnu6TT2MGs3PIIqcY6luhlMno0G/WM8zpMzt1d0J3cf+d7+bHbtzk7E
fg5jcisn21GU32hjUdyuq2NjzmY8v6pYvdO6z/i9vdwPIr6WIfYXBP7huzzItule/GQO8dzG
ARNhd7cjWdvu9YT+eQdhDrXNFQjTULx1wl/Lb0g28/vjdUY3q63cngaTvLfErdM5B9+lCVGw
oK21J/4mNjCVq/Rhq7TgBMXy9PBmoXQarFe0zRsGaKs0uerQPpu44a9gxIppvQyNgO6bB2ER
uFXoctsV/65RFYHj/Vbc9TxJ22fzD8twjGmOODJAtya9GIZnA7FBeNGl8wRy77YG4YLT9baI
/29xx9qcuJH8zq+YqvuwUAVCT8DUbSoY8NqJsQnC3uQoFyUkYXQGSZGE175ff909oxcvL5tU
ZVPBIHX3PPoxj+7pwUNyxAh+dGSOZObjyX3/ypyP778OJ8wG0FzGgEzPsUI8azbroc8/WC4b
WONaxfPDbYKOVofxDUKU1KbYUWze3v1u/mFORyAJ/Pvlg4nf6ZiWPMCvRIB/prEMBWKz25vB
U1rIGGQmYpfbJAn8M4rp7xSTSXWR3Gx8Ob3LSuJH484uabhTkipKKpGbmVQSnbIeWRGdKcfD
2Fs/5hLubGnCi89W1ppnl8DDkoIY7bfi76JIEDfFocpKIs72QgWn18PJSMwdM2CLjqojyBxT
WKTdnh4JpkwWs+n16AmPv7N+rWKCEllrGHxUQ24qLcOQhbu9DvMgihSrk/qDXpO2ZWmbxNia
JO+mTDaieY8hm8sOq3rRn+wz0+t05HK+sLYO/FQw44JcQ6G1GBXU+zBeZccEGfvm0zhkPbnz
3XoOnzE9Tx5x8CpLiqxVxIsGvljnO4Bk0OjAMusYxnjE+isvhLJOwve+jJkVuhH59qFpitoZ
sZ9ZfpCoMnOizVPR3w/9u2GwhpJkDD1ooYtMAEWgyyBFaQoIjBIRTRUdIQlAr5j74gB4dfII
7KSoOlywven9Vot+qZ0u7iUpg1pKKpUdttmAXUKGYc6Eqz5PrnUQSBhDzPLxYd+o0Eq+lDoJ
CgpFFUeURzUdUAAyYPobNa0iOqc8/vwo3pfptMt5Jb8NBacoP8SwTRn+rg6jPU56owwvne0P
OwX87CEnc8WqmjqiREM10ZdZ9gUkhuEWn5FeHbdg6JsAw5d0Up0HzcZsMJhUZtMpaC4psWA7
9HKWueQ5ssKVZ8dZlh1dN1SlxV68yyKmSDlyErOlG+2WXMAsZVuhIZESheDp5ZLwYgaHEQuW
vHUii0kEg+D7Dhh1IsABJ0pg0g5cSJZ8Y/kw8OJ521I000Emfb3MjdRBgKXr50FF8DbiJ+PR
bfwcbnEzNSpwMlVkcsbZ+ftlR1bUXEXMNK72dbG2wIJhLgww+puQEu1gCRP3FVYvVRVUX5ZU
WdEyHRQxQVloLg75HtRmj9SfWzfa6yG0tl4xnIi/voWZARWL+S1Gng2zB1SHMi41nc7UZ4Ir
81CUFJBmWC7mosCcGi4eNYUxS8HesuPUHC0OgMglkLGFNupmwExKaQHjzS/ttqErujLWK8Wk
BiV4k/a0Ya0GpstIq3QH4+cjG+D8x18GwtMJBaJ/M1UezvaBF4foPe0HMH+3QVTT2mQPmNwV
jxhmWGko2a/BoN+lPebv+MiQhj72cRTnRBnrT6ZKF5MADid3vds51FvZq4WSIwwebxqDQj2u
x4P9Sunf8XGyUoOrcbFS09HA3K+VmmPcPg7MQqUOkbztD4okEWOPopYjmI83g+H9BzSnjztd
p4qXywUlJSTjReILRlgvDFivkbVhmLUwyl4XR2PuK9HbnZbRyik6bgjmFgbxTl6FkKaqOLDr
cqeyXNikNSReAAJI1eWCT2rCyNtYYMX4GJTn74lptktqFKTJfJZQPTcNsxODltI23lrGEYu1
kMulHiBwGLMwNQwt37MxQsRbem5qtYvzEkFAlXQxN+nIhtqhxUaRKKNkxpjRQ64sIqcrVsNp
pKqVWPPQ8952HM9pxKkqKdoxmDSfXdolmMLLYI2fEKxdq8R27NHBdfTECAr5Q6XwEL5gsFRv
2qM8LA+DUa+p4FmEjYPToCV8S9Y0W22xxQaDL/ihRrKlio746gn8dobfLuF3OL4BC2XfTTQV
gzbpi2R3XxVJMxgY/14YSdi3LIkXwbPrOz9b63BlScBS/8X1JbDRybOGGBp0VZtVR2DBFFgE
w5Chf7wsXFgJsPv9b1kbXgpa5jpI2OyyN8WkGWkBImn1P1wjpVAja8ErhNyTcF0E/ONLNG9D
6/zB42DylZn35tdGx1DNOhubU62es1gjyVRS3Eary64efrmZmg9sdD1VQR96Uza+rYM8qmq9
JBo5omK0NOBUpwPrFBpzABAW9B76124veyyvXmEHD/tprwqH3mNRJPKgNvQfDHLQ70mjx/NB
4D8UW/q3W3mqNxv/hpk0e3cmdI1RiZ2c1Cx2rKdCAwxFbeCuC/DtmRLOU4R83GXVDtqBL5fN
ti4Z7It3WTtA5ysmn2ZjniQbuR8slwfARnjUwXR9WnjITLMYJbY9SpBioLvpiqhOs8a9h07g
xpglIw3RHozvGXTh1UOP956SUu4PGpP7UXECckxaGEnLTu8xqFgXPxT8UNm/8Y+BHy32E/7R
DrSjlyQWRVtRnD7MVV9Q43P/Gvatm6wAfuo9B77GZiGsm/ygetkfXRht2egZMOREMJ3UYK4G
CoCrYk0bXf+vqwHDvKTGRjA7wnkqigRSXYKF7dqdbqvdbbnHSrPSeo2v/0B+YVGsqsgodPi/
jCm7G1M2xB0GsGs1Vv0KwmeGMOebKU91NhwOZ/JT7Rj9ye92vN3EAEqL/P7qeTL8gnk3Rzdg
N/FLz7zCP1Pz3rZCgDtGCSzuPPpmJ9F61m5pFPj8RA8xSdaspTfomKGryHIxBdnknoz4nZt8
C6IXMeuuM00yJFVvvKiNOzAXAis7HlC1a0y5uLjAEwItsT1QyMlP4AdK2S0GFofpCNiWNElV
Gi+dvLxigeyDEqXKO1g5a25bkVP0R3Gf9aEhVBZDqFY7ibrjsObz6hnfM1AU5+kk8r1aKJtU
En0xLsx8mpSEHuYqUZxI7GbJ3oMtc98wNxqtw2C0AJ3dxKifYSHHmxfHW9wwxmUZbvHy0oVD
ABQCJkC4I/EpUOcxSuA2/AwG5tPJWt6YPdo1ojT5GIx00anT9hON28pJXJOXjPmmtpjjlU8o
WydxQntje2AgoLq4dC14vblfuXvEHYpYWVOLv3BUgMJv7mlrjvrOLaN3K9C59npLa7+Sa7Hs
OCx76Mr+t7/appMu24/aJjYD0qYdoLLTxGU7T8nU4e5NfGrlTxf86d/TrFMe5TPbdoDUTtsO
QBxvxZEZ9Peo/368yhnqr/wFxVIOK5auyCdx/nbFUv5hxfq+Nv2YYin/nGKd06wfUqzDbfsx
xXJXtjdf2bCixaOPuHP9aeiv6DzfJ3aNCdP6/Ngl+u2qw+v+TU2M7oTaCG2vy/AxNTJcWwkO
ZmKjMQPJ17yUqongd4gfg8UjkVg1niUtXdjX87A9fOFvNwuon3KMiOMuts9cyo/C8Ny15Lek
rZJgiR5cmBKWbn85hs11vs5AA8u5ro4hpN1N1ylgg6hTcBGEJ0Px3Cew+U40Xlg2sk9QhvMI
S+gg+qw4rQX+hPWGs7WTz1CAehybJ9YFwRkto8+wBEyxYFXHHWJ31IuflQIJAXOEZTncyPK3
S4tOe0bimGrx7rBUygoYxSK7pb6prLYLpjTgB45R2AB8QG0vv2pxXx20j3sXKtuSMD/4KIMx
LOF25fhm5zxuhlisB5Z9sNGHYc+RU/UYkYIU8UuOaIsaE9+lPaf+iFAox7HPFgq1IBSH+yeD
+0AotjtCoZ4QCpk4rx4XiuyVekwoiuSUM3irnMdb7RiRY7zVM95qf4m3+9hn81b7Tt5qZ/NW
O8FbhRioHeetdhZv1TN4q57HW/0YkWO8VTPe6n+Jt/vYZ/NW/07e6mfzVj/BW5UYqB/nrX6c
t2fkXmjESRBZz27F68g6Wqi7MXyYTbVo9Wfi1GX318t+XRze7I5NdfTE/SUtuU6OJGJmXVEr
MaYyB+YiTfbr5YBPIPZhy4C9h9+PAaqVTYBucfdV1I5+pizFO1MCn7Y9rfWabdC/kUYK9ZkZ
utYLunYK0TvpdKsZ2nH4EhVDdfTKynMi6xu6UL6x65uByLCedlq1X2O/eJHHfg1iz7fO6m2g
XOF/OEeROiKno6modG/Kphg9yG9LMGEWq2Kc2iKAKfPhZlAHNqk3S3FHGoma0tC4uqIzv0H7
H0WNSMdWkXY4nXblqB/on6ypelH/FrbcOopcUj/luPoVap5p36R3e/uHmr8oq9t9/z9s6tor
P1gHz+85VFnFej08Cau2wUaoHaNtVApKQPCZuo0wE5Up3qS5RVIdyxxJapcdoPDBIiS0cfWD
0jnq3/QY/gB5AfYl5A1PAhajy0L5gXXaIruRr7BOQ7eILwlqrLSDERViIwtJVPhr9OxhihxY
Z9cqse/MKRqn8yYXXXFGl6WP5xvXioEbc8u+aM/pbDDWkJ45zFChv7mfn1VVQ9NZbG3CNYZp
nqBNVIRDVKekYFtNZDzjrknchidhz8wBXtDCAp/e9Og+1WIAdMULvRAW7+NXnU7982/JFqN2
aTNE6GI457HTXVJ5DN7ge6x3brL01uK2VRdEztrwsGl7uyjcBvE9tyPIH4O0PwYxKh1ZVf7s
MvgjKb+xx9veXRphwl4VqZPHrjp+fDC4laeTuRnfMHMFWPY24eFQ2eUxvpvA98L9MfwBd1r7
YvMa9O4Z6YiVWYX3ZNwEgs2VnQTxeyzZeFUreeKBn0GIZ+sTO9uAgu94ycCt2Usf4bVaeKPR
v/JwO7UjK4PLBmXeJXegOe31L9qGXDcUHDtwxDAyW7oOYxoxerdjkw221nqMF66AYnsgJB8Z
U6VoTNsf0ZwGW3s1tj620SWyrcpXy6O4NBzAojxpFMtu/ZIkiVsc9bgfD80f/eNWsuCjUtCP
UfREyazfN9HVpBZcTYsn1u5oimGoJzx5OmaA+nLZ1KS2lnnydqgc8+TtgBU9ebrG3XjCk7cD
eRewvoiKQqHkF4zyidA+cC+Ot5tMjVNXH/cqZFfbAiT64RbKIQIlfxtdYsyDcdHzNvx9qjeW
YL4QudbleTTQdbjBSySQ7+5boqWBu0vX4pGePsxQQivx6DI4THS0S4fQafB9S1S2xPs5RKYJ
cVfSysVXep6n6zAJdP4CssBF5QhAlf8bbCPfWkvsPsSbYqr+dr2uVR4xNH4ksEjsqlnpnECN
fDOBD0YGr2DlQtnpKm2pcB2MKLdyFbkuVnXr00WJpZvJuvzis2rhAq/0+q5aZQu0nNlF66nL
DQcSSb1fSketgE2Y25uAuyYxYzDYi70ZVwYELEAjsodlra1ogxn1yO74wE/rvQ6qIZJhMR+D
gETcAD+nwK9ZYbPHG0xWR175xgr6o8veAR56bINXWDLMqpbgtywEnqPj7vj3Bozz6xwEKMz+
EYAinnbCyDsVT7WJZHr6IR2tHNuB9RPjf8St4DxDcIzTpDQckq5RFj7GatrJhtSCFYomqaDN
Ue7snsUR2Hs0O1pjs7F5SbDc0N+a8D9XqYjZTjP6xt6sJto4GJcdx8KjL+8V26EeevA92tcU
rnMxF56Iy3pAMCRY6hWLzfSPDJ5Ag6pUYEbs8D73F+mcgGJLvbgU5gnDeQvIDAYTDBOpwvA5
GD7OH8agI9wfvMaYcbE9yYNNP0CRNDzTuI/mL+cwBvqY9PIlE1lZMnDWJC5R3OJULa6LWw43
1luthDX3wlcdR8QXP/jmFx2VJaiVuw7d6BMTV4bA3KR1xuTkBs8TrGlu8+IvweJV7dx93Cf3
cYsFL170M6yiLEeKvy0kx63BkPNqd9ObaZL8RBjeFvrivCpsAqsrzItDQ7cbRaANF23Au7sy
B2mKuuarFTXX3qIJJTdfdczC+UrhN/yWPDo5Rd4cl2XvHBrcwG4ISplZuJAbMabxdDAGGWep
dGUWGDSX3x/bbl3otT3LGLkNYaR2LOD/AZToaoqygQAA
--------------040909050301080605050207--
