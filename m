From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 11:48:59 -0700
Message-ID: <200607241149.01700.david-b@pacbell.net>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
	<20060724172954.GC1926@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060724172954.GC1926@elf.ucw.cz>
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
To: linux-pm@lists.osdl.org
Cc: patrick.mochel@intel.com, Pavel Machek <pavel@ucw.cz>, Matthew Locke <matt@nomadgs.com>, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Monday 24 July 2006 10:29 am, Pavel Machek wrote:

> That looks quite ugly to do in sysfs, indeed.

Yes, it's long been one of the things I most dislike about this PowerOP thi=
ng.
Not just the UI, but the models it reflects.

So I was glad to see it split out as fully optional... although from what I
see, the internal models in the code have derived from this sysfs model, so
I'd argue those need to change too.

It'd be lots better to just have named operating points that get selected j=
ust
the /sys/power/state file selects the, erm, "sleep point".


> But better run this by lkml.

I'd rather see some rough consensus on this list that this is the right way
to head, before running things like this by LKML.  =


- Dave
