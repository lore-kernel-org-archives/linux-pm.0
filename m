From: "Li Qiang-E3422C" <E3422C@motorola.com>
Subject: RE: apm for individual devices
Date: Tue, 7 Mar 2006 10:11:31 +0800
Message-ID: <105E3883E4A2524BB0B1281D1599C473CA93F8@zmy16exm62.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============50582618881165287=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============50582618881165287==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

'0' indicates the device is on. Other values (1-3) indicate the device
is in a low power state. 
You can see ACPI's spec.

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Tehn Yit Chin
Sent: Tuesday, March 07, 2006 9:30 AM
To: Tehn Yit Chin
Cc: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] apm for individual devices


Tehn Yit Chin wrote:
> Hi all,
> 
> How does one use the sysfs entry of power/state that I can find for 
> each registered device? Eg, for the i2c device on my s3c2410 cpu, I 
> find the following entry,
> 
> /sys/devices/platform/s3c2410-i2c/power/state
> 
> I tried echoing "mem" into it, but nothing seems to happen.
> 
> What I am looking for is a way of suspending and resuming individual 
> devices within the PM architecture?
> 
> Any pointers would be greatly appreciated.

After reading through the mailing list archives, I sort of work it out.
ie

echo -n 1 > /sys/devices/platform/s3c2410-i2c/power/state

puts the device into suspend mode.

However, the driver's behaviour doesn't change if I echo a different
number into it. What does this number suppose to do?

Tehn Yit Chin
Software Engineer, Grey Innovation Pty. Ltd.

_______________________________________________
linux-pm mailing list
linux-pm@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/linux-pm


--===============50582618881165287==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============50582618881165287==--
