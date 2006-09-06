From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 6 Sep 2006 12:56:44 +0200
Message-ID: <20060906105643.GH4987@atrey.karlin.mff.cuni.cz>
References: <200609051603.k85G3Xsm017278@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609051603.k85G3Xsm017278@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> We have thought about merging the decisions into a single range of
> operating points, but the added plumbing to get idle information back to
> the policy manager seemed unappealing.
> =

> We don't use cpufreq, so Pavel's arguments about not changing the kernel
> interface weren't a concern, for us. We're using a kernel interface that
> is all our own (and unappealingly ioctl-based).

Well, but you can see that my arguments are quite important for
mainline merge? ;-).

Of course, powerop/oppoint patches are okay for your own use.
							Pavel
-- =

Thanks, Sharp!
