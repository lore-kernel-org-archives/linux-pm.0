From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sat, 14 Feb 2009 01:06:32 +0000
Message-ID: <20090214010632.GA6618@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<d6200be20902131536x5c0ec741hdbfb63c0b2ae79c0@mail.gmail.com>
	<20090214000520.GA5764@srcf.ucam.org>
	<d6200be20902131650n33f46958j4d8630694c49a400@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902131650n33f46958j4d8630694c49a400@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 04:50:11PM -0800, Arve Hj=F8nnev=E5g wrote:
> On Fri, Feb 13, 2009 at 4:05 PM, Matthew Garrett <mjg59@srcf.ucam.org> wr=
ote:
> > The only reason you've given for needing a timeout is that there are
> > sections of the kernel that don't support wakelocks.
> =

> Or when not trusting userspace. In the last user space api, I also use
> a timeout when a process dies with a wakelock locked.

That's policy that's easily to implement in userspace.

> > The only reason
> > there are sections of the kernel that don't support wakelocks is that
> > people don't like the API.
> =

> That is a pretty big leap. There is no wakelock api in the current
> kernel. I think the absence of an api is a more plausible explanation
> for it not being used than that people do not like the api.

If an acceptable API gets merged then there's no reason not to quickly =

spread it to the sections of the kernel which would benefit.

> > Well, yeah, that's another pretty solid argument in favor of killing the
> > freezer...
> =

> Not freezing threads does not solve the problem. The thread could be
> waiting for a driver that is suspended before the driver that is
> preventing suspend.

I think it would be pretty acceptable to schedule a retry for the =

suspend if the count is still zero at that point.

> > Mm? I was thinking that in the debug case you'd replace the counter with
> > a list containing the device structs, then simply dump the device name
> > to your debug output.
> =

> We always use the debug case. I don't think a list of device struct is
> better than a list of wakelocks.

You may. Others will not. There's benefit in simplifying the non-debug =

case.

> > If you're passing a device struct then I think it implies that that
> > device is no linger inhibiting suspend.
> =

> How is passing the device struct to the api better than passing a
> wake_lock struct?

It's not hugely, but it seems like a neater description of what's going =

on. I don't really object to the use of a struct wait_lock - I think =

it's more complicated than necessary for the vast majority of cases, but =

that's not a significant issue. I think the name doesn't do a good job =

of indicating what's going on, and I think the timeout aspect is a =

misfeature.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
