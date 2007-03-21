From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Wed, 21 Mar 2007 17:21:47 +0200
Message-ID: <52d486620703210821h3e26b167kb12a197d7b46e04d@mail.gmail.com>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<20070320183022.GC2670@elf.ucw.cz>
	<1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 3/21/07, Shaohua Li <shaohua.li@intel.com> wrote:
> On Wed, 2007-03-21 at 02:30 +0800, Pavel Machek wrote:

> > No, that's not how it works; look at hda_audio, it already has
> > powersave. Just power down audio card 5 seconds after its control file
> > is closed.
> It's another case of doing policy in a driver.
>

IMHO, this kind of policy is best handled inside the driver because it
is specific to the hardware. This will ensure that the driver will
just work on every distro without some userspace policy being present
and setup _correctly_.

In the above case if the driver runs on a single architecture, chances
are you can figure out what the best value (5s) for that arch is and
hardwire it.

If the driver indeed runs on multiple architectures that have
drastically different notions of the optimum values, then I guess it
could be exposed through sysfs.  Even then, it doesn't seem likely
that the value would be changed from what it is initialized to.

I have yet to come across drivers where you change these values
several times at runtime. If I am simply being ignorant, I would
appreciate some examples.

Regards,
Amit
--
Amit Kucheria, NOKIA
