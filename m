From: Andy Kennedy <akennedy@techmoninc.com>
Subject: Ejecting/Powering off/ -> Turn off the device lamp.
Date: Mon, 22 May 2006 11:21:52 -0500
Message-ID: <4471E520.1090008@techmoninc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020908070709080409070001"
Return-path: <linux-pm-bounces@lists.osdl.org>
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
--------------020908070709080409070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

All,

I have done an extensive search on this issue and cannot find the answer 
to my specific question.  Whereas I understand that an individual device 
on a USB host (on board) cannot be "powered off" nor "ejected" I wonder 
if the device can be sent a command from userspace to turn off it's LED 
indicator lamp.  Most of the devices that I have seen, when the device 
is no longer in use, goes into a blink cycle.

Is there a way to signal the device to stop the cycle and actually power 
off the LED?

Thanks in advance for any help you can give.

Andy Kennedy

--------------020908070709080409070001
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


--------------020908070709080409070001
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------020908070709080409070001--
