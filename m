From: Jan Holst Jensen <jan@jan-holst.dk>
Subject: Re: EHCI_HCD resets cause USB disks to fail - caused by
	CPU C-states.
Date: Sat, 19 Sep 2009 11:51:17 +0200
Message-ID: <4AB4A995.6060709@jan-holst.dk>
References: <Pine.LNX.4.44L0.0909181443300.3123-100000@iolanthe.rowland.org>
Reply-To: jan@jan-holst.dk
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1231039005352007310=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0909181443300.3123-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--===============1231039005352007310==
Content-Type: multipart/alternative;
 boundary="------------080306080007000606060508"

This is a multi-part message in MIME format.
--------------080306080007000606060508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Stern wrote:
> [Adding CC's, since this is a CPU power management issue just as much 
> as a USB issue.]
>
> On Fri, 18 Sep 2009, Jan Holst Jensen wrote:
>
>   
>> Hi.
>>
>> I recently had severe problems with a new PC. When attaching an external 
>> USB disk I would see USB resets once in a while in /var/log/messages and 
>> after another while the disk would disconnect and data would be lost. 
>> Like this
>>
>> Sep 13 13:30:56 rumleskaft kernel: [164642.760290] usb 1-5: reset high 
>> speed USB device using ehci_hcd and address 3
>> [repeated a number of times]
>> Sep 13 13:31:17 rumleskaft kernel: [164663.430421] sd 2:0:0:0: Device 
>> offlined - not ready after error recovery
>> Sep 13 13:31:17 rumleskaft kernel: [164663.430459] sd 2:0:0:0: [sdb] 
>> Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK,SUGGEST_OK
>> Sep 13 13:31:17 rumleskaft kernel: [164663.436193] usb 1-5: USB 
>> disconnect, address 3
>> Sep 13 13:31:17 rumleskaft kernel: [164663.436446] sd 2:0:0:0: [sdb] 
>> Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
>> Sep 13 13:31:17 rumleskaft kernel: [164663.437711] lost page write due 
>> to I/O error on sdb2
>> Sep 13 13:31:17 rumleskaft kernel: [164663.454184] lost page write due 
>> to I/O error on sdb2
>>
>> On my machine I found that disabling CPU C-states and forcing "GV3 only" 
>> solved the problem completely. So in some cases it would seem that CPU 
>> power management is causing timing issues (?). Can this be fixed in the 
>> USB driver layer or does it take cooperation from the kernel's CPU power 
>> management - or perhaps a combination of both ?
>>
>> You can read more details about my issue at
>>
>> http://www.fit-pc2.com/forum/viewtopic.php?f=26&t=851
>>
>> Cheers
>> -- Jan Holst Jensen, Denmark
>>     
>
> For what it's worth, I haven't heard of anything like this before and I
> have no idea what the answers are.  My guess is that a hardware bug is
> responsible for the misbehavior while in higher C states.
>
> Alan Stern
>   

Could be. Hardware info for my system can be found at 
http://www.jan-holst.dk/linux-usb/sysconfig.txt. It is the output of 
/proc/version, /etc/issue and lshw.

-- Jan

--------------080306080007000606060508
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Alan Stern wrote:
<blockquote
 cite="mid:Pine.LNX.4.44L0.0909181443300.3123-100000@iolanthe.rowland.org"
 type="cite">
  <pre wrap="">[Adding CC's, since this is a CPU power management issue just as much 
as a USB issue.]

On Fri, 18 Sep 2009, Jan Holst Jensen wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi.

I recently had severe problems with a new PC. When attaching an external 
USB disk I would see USB resets once in a while in /var/log/messages and 
after another while the disk would disconnect and data would be lost. 
Like this

Sep 13 13:30:56 rumleskaft kernel: [164642.760290] usb 1-5: reset high 
speed USB device using ehci_hcd and address 3
[repeated a number of times]
Sep 13 13:31:17 rumleskaft kernel: [164663.430421] sd 2:0:0:0: Device 
offlined - not ready after error recovery
Sep 13 13:31:17 rumleskaft kernel: [164663.430459] sd 2:0:0:0: [sdb] 
Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK,SUGGEST_OK
Sep 13 13:31:17 rumleskaft kernel: [164663.436193] usb 1-5: USB 
disconnect, address 3
Sep 13 13:31:17 rumleskaft kernel: [164663.436446] sd 2:0:0:0: [sdb] 
Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
Sep 13 13:31:17 rumleskaft kernel: [164663.437711] lost page write due 
to I/O error on sdb2
Sep 13 13:31:17 rumleskaft kernel: [164663.454184] lost page write due 
to I/O error on sdb2

On my machine I found that disabling CPU C-states and forcing "GV3 only" 
solved the problem completely. So in some cases it would seem that CPU 
power management is causing timing issues (?). Can this be fixed in the 
USB driver layer or does it take cooperation from the kernel's CPU power 
management - or perhaps a combination of both ?

You can read more details about my issue at

<a class="moz-txt-link-freetext" href="http://www.fit-pc2.com/forum/viewtopic.php?f=26&t=851">http://www.fit-pc2.com/forum/viewtopic.php?f=26&amp;t=851</a>

Cheers
-- Jan Holst Jensen, Denmark
    </pre>
  </blockquote>
  <pre wrap=""><!---->
For what it's worth, I haven't heard of anything like this before and I
have no idea what the answers are.  My guess is that a hardware bug is
responsible for the misbehavior while in higher C states.

Alan Stern
  </pre>
</blockquote>
<br>
Could be. Hardware info for my system can be found at <a
 href="http://www.jan-holst.dk/linux-usb/sysconfig.txt">http://www.jan-holst.dk/linux-usb/sysconfig.txt</a>.
It is the output of /proc/version, /etc/issue and lshw.<br>
<br>
-- Jan<br>
</body>
</html>

--------------080306080007000606060508--

--===============1231039005352007310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1231039005352007310==--
