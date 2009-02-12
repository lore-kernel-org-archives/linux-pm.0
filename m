From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 12 Feb 2009 23:22:30 +0100
Message-ID: <200902122322.30864.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902112323.53421.rjw@sisk.pl>
	<d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 12 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Wed, Feb 11, 2009 at 2:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> >> >> It allows wakelocks with timeouts
[--snip--]
> > Well, you put quite a lot of effort into making this nicely debuggable =
and so
> > on, but I think you should have submitted the minimal core functionalit=
y first
> > to see if people were comfortable with it.
> =

> The code I submitted is usable and tested.

Unfortunately, that doesn't help it a lot.  There's a lot of usable and tes=
ted
code out of the kernel.

In general, kernel code is mergeable if people agree with it, which is not =
the
case with your patches.

> Without wakelocks we cannot use suspend, and without wakelock timeouts
> we cannot pass events to components that do not use wakelocks.

This is a very strong statement, as though there had not been any alternati=
ve
to the wakelocks.  I don't really think it's the case.

Thanks,
Rafael
