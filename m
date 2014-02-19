From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Wed, 19 Feb 2014 11:10:31 -0800
Message-ID: <530501A7.2030703@ti.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sebastian Capella <sebastian.capella@linaro.org>
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Pavel Machek <pavel@ucw.cz>, Catalin Marinas <Catalin.Marinas@arm.com>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/19/2014 08:12 AM, Lorenzo Pieralisi wrote:

+ *  https://patchwork.kernel.org/patch/96442/


I think the idea here is to get the CPU into a state so that later
when we resume from the resume kernel, the actual CPU state matches
the state we have in kernel. The main thing flush_thread does is clear
out any and all FP state.

The may be part of the patchset that is OBE.



cpu_resume makes many assumptions about the state of the state of the
CPU, the primary being that the MMU is disabled, but also that all
caches and IRQs are disabled. soft_restart does all this for us.



ah, you are saying just return from __swsusp_arch_save_image and allow
cpu_suspend_abort to be called, placing the result of swsusp_save
somewhere else. This may work and would reduce the complexity of the
code slightly.



This is taken from the previous iteration of the patchset, I think the
comment is OBE.



But this is still required to select the right mapping for our copying.



I don't remember why I needed to prevent gcc from manipulating the
stack here.



This is another holdover from previous patch versions that may be OBE.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMFAaYACgkQfNRrxBinbdsWTwCgowSU7VPqGcM4ks39FtAihsBe
vfYAn3gxZEu753xyESuye0y1z+wbWJRp
=JZ1s
-----END PGP SIGNATURE-----
