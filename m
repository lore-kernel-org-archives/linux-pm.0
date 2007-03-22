From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 12:20:09 -0700
Message-ID: <200703221220.09679.david-b@pacbell.net>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
	<20070321213909.GB6057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321213909.GB6057@elf.ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 March 2007 2:39 pm, Pavel Machek wrote:

> > > USB gets the dependencies right, just copy that.
> > Does USB include all kinds of dependence, eg non parent-children
> > dependence?
> =

> No, probably not, as USB was designed properly.

It was designed to work with as few wires as possible:  "minimalist"
design.  That's not the same as "proper"; not everything works with
the same design constraints.


> How common are those cross dependencies?

Common.  SOC audio setups are relatively simple examples, which
I know have been making trouble on Linux for some time.  One hopes
that the new ALSA SOC stuff helps sort this out:

  - SOC serial controller (I2S, AC97, McBSP, SII, etc) manages
    encoded data bitsteams (e.g. N channels, PCM or uLaw, etc)
    for input, output, or both.

  - External codec interprets those bitstreams.

  - That codec is controlled using I2C, SPI, or some other bus
    for control, e.g. "set volume", "enter stereo mode".

  - The codec and serial controllers have separate power controls.

Think of this as separate control, data, and power channels;
which are not multiplexed like USB.

At the hardware level it probably looks like two different driver
model devices (I2S/etc, and codec) that could have semi-generic
drivers (I think this is what the ALSA SOC stuff is aiming for),
plus board-specific "power codec on/off" interfaces.  Then there
are the /dev interfaces ALSA creates for each functionality.


> Do we really want to solve them generically? =


What we need to be generic is:  PM not preventing good solutions.
I'm not sure we're there yet.

- Dave
