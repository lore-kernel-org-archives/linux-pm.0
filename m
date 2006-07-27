From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 17:15:21 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D01F92E2A@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Pavel Machek <pavel@ucw.cz>, "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Matthew Locke <matt@nomadgs.com>, "Mochel,
	Patrick" <patrick.mochel@intel.com>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel
>Machek
>Sent: Monday, July 24, 2006 10:30 AM
>To: Eugeny S. Mints
>Cc: Matthew Locke; Mochel, Patrick; linux-pm@lists.osdl.org;
sampsa.fabritius@nokia.com;
>linux@dominikbrodowski.net
>Subject: Re: [linux-pm] [RFC] PowerOP Take 3, sysfs UI core 2/5
>
>Hi!
>
>> A sysfs interface for PowerOP that allows operating points to be
created
>> and activated from userspace.
>>
>> The platform-specific backend provides the code to read and write
sysfs
>> attributes for each power parameter; the core sysfs interface has no
>> knowledge of the struct powerop_point contents.  This interface could
be
>> seen as possible extension of cpufreq sysfs.  It is not
>> an integral part of PowerOP and is provided in part to facilitate
>> discussion and experimentation with PowerOP, but could serve as a
basis
>> for a basic userspace power policy management stack.
>>
>> Operating points are created by writing the name of the operating
point
>> to /sys/powerop/new.  This may be a job for configfs.
>
>That looks quite ugly to do in sysfs, indeed.
>
>And it definitely needs some Documentation/ patch. But better run this
>by lkml.

It's too soon for that.

--mgross
