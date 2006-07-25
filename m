From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 17:32:55 -0700
Message-ID: <200607241732.57588.david-b@pacbell.net>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD018ACC7B@de01exm64.ds.mot.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: patrick.mochel@intel.com, Pavel Machek <pavel@ucw.cz>, Matthew Locke <matt@nomadgs.com>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Monday 24 July 2006 2:58 pm, Preece Scott-PREECE wrote:
> If they're defined dynamically, you can change them without recompiling
> the system, building a new rootfs image, etc. This is especially useful
> during development and tuning of systems built on new hardware, since
> the set of Ops available (that is, that are documented by the chip
> vendor to work) can vary over time and even board-to-board.

I could easily buy such a mechanism being dependent on EXPERIMENTAL,
for use with developer/prototype boards ... thanks for that scenario.

But I have a harder time seeing it used in production systems, burnt
into flash on a manufacturing line that already had to qualify that
new hardware before the next production run (of say 10,000 units) was
approved by the powers-that-be.

- Dave


> > I meant "they could suggest how to do the sysfs thing, in reasonable =

> > way". Like echo new_config > file is extermely ugly, but perhaps =

> > configfs is suitable?
> =

> Makes some sense.  But I'm still puzzled why _creating_ an operating
> point would be done outside of the arch/.../board-xx.c file. =
