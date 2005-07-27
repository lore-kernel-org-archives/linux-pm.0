From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: sysdev suspend/resume
Date: Wed, 27 Jul 2005 11:50:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.50.0507271149300.24395-100000@monsoon.he.net>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
	<20050726101409.GA1950@openzaurus.ucw.cz>
	<1122454220.7414.3.camel@linux-hp.sh.intel.com>
	<20050727090748.GB4270@elf.ucw.cz>
	<1122456610.3000.5.camel@linux-hp.sh.intel.com>
	<Pine.LNX.4.50.0507271035590.17623-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86732887650667578=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0507271035590.17623-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============86732887650667578==
Content-Type: TEXT/PLAIN; charset=US-ASCII


One small correction that one eagle-eyed participant noticed:

On Wed, 27 Jul 2005, Patrick Mochel wrote:

> So, the first few lines should be
>
> static void __sysdev_resume(struct sys_device * dev)
> {
> 	struct sysdev_class * cls = dev->cls;
> 	struct sysdev_driver * dev;

That should be:

	struct sysdev_driver * drv;

Thanks,


	Pat

--===============86732887650667578==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86732887650667578==--
