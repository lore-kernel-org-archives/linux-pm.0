From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: apm for individual devices
Date: Mon, 6 Mar 2006 18:58:31 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0603061855350.31818-100000@monsoon.he.net>
References: <440CD773.6010401@greyinnovation.com>
	<440CE22E.8060601@greyinnovation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============086578371382004082=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <440CE22E.8060601@greyinnovation.com>
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

--===============086578371382004082==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 7 Mar 2006, Tehn Yit Chin wrote:

> After reading through the mailing list archives, I sort of work it out. ie
>
> echo -n 1 > /sys/devices/platform/s3c2410-i2c/power/state
>
> puts the device into suspend mode.
>
> However, the driver's behaviour doesn't change if I echo a different
> number into it. What does this number suppose to do?

It depends on how the i2c subsystem (and possibly the driver) treats the
number. It might have only 2 states - on (0) and off (1). But, you'll have
to check the i2c documentation, the code, and possibly the developers to
know for sure..

Thanks,


	Patrick

--===============086578371382004082==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============086578371382004082==--
