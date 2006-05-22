From: Andy Kennedy <akennedy@techmoninc.com>
Subject: Re: Ejecting/Powering off/ -> Turn off the device lamp.
Date: Mon, 22 May 2006 11:50:10 -0500
Message-ID: <4471EBC2.9000607@techmoninc.com>
References: <Pine.LNX.4.44L0.0605221238290.5806-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070509090207020200060308"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0605221238290.5806-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------070509090207020200060308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Stern wrote:
> On Mon, 22 May 2006, Andy Kennedy wrote:
>
>   
>> All,
>>
>> I have done an extensive search on this issue and cannot find the answer 
>> to my specific question.  Whereas I understand that an individual device 
>> on a USB host (on board) cannot be "powered off" nor "ejected" I wonder 
>> if the device can be sent a command from userspace to turn off it's LED 
>> indicator lamp.  Most of the devices that I have seen, when the device 
>> is no longer in use, goes into a blink cycle.
>>
>> Is there a way to signal the device to stop the cycle and actually power 
>> off the LED?
>>     
>
> It's hard to answer that question without knowing what kind of device
> you're talking about.  Some USB devices (like hubs) can be told to turn
> off their indicators; most cannot.
>
> Alan Stern
>   
Very sorry. . . I did leave out the most important part:  I am working 
with various flash disks / USB mass storage devices.

I am working with an embedded system that will have no user interaction 
save the USB port.  The unit will recognize the mass storage device via 
the hotplug scripts, then execute a series of commands. . . after which 
the device will be unmounted and then could be removed.  That is the 
purpose for wanting to extinguish the lamp.  It would be hard to explain 
to a lay person to "Watch the little light.  It should blink very fast 
for a few seconds/minutes then blink slow for a few seconds, then fast 
again. . . then you can remove it." and expect them to comprehend the 
meaning of the "little blinking light."

I have TTLs on the embedded system; I may just have to use those.

Andy Kennedy

--------------070509090207020200060308
Content-Type: text/x-vcard; charset=utf-8;
 name="akennedy.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="akennedy.vcf"

begin:vcard
fn:Andy Kennedy
n:;Andy Kennedy
org:TechMon Research Inc.
adr;dom:;;2221 Dianne Drive;Birmingham;AL;35235
email;internet:akennedy@techmoninc.com
title:Sr. Software Engineer
tel;work:(205) 854-9895
tel;cell:(256) 453-1814
version:2.1
end:vcard


--------------070509090207020200060308
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------070509090207020200060308--
