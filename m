From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 10:39:18 +1000
Message-ID: <1151109558.16946.50.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606231706180.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231706180.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-06-23 at 17:10 -0700, Linus Torvalds wrote:

> It's clear that people who I thought should know better are just too used =

> to the status quo, and as such, any change is automatically a bad thing.

What status quo ? I've proposed a set of changes that will help fix
known and identified issues.

I just don't propose to change a whole model that works with one that I
know won't work just for the sake of supposedly improving an
debuggability problem which isn't even there. Debugging suspend() is
easy. Just prevent the console from going to sleep and don't put the
machine in S3 at the ned of the process (just go through the device
model suspend and reusme right away with a hack to not suspend the
console driver and its parents if any).

The problems are in resume most of the time and you aren't fixing any of
this. On the contrary, you will _introduce_ new problems in suspend in
fact if you start going away from the model where suspend has to make
sure we stop processing incoming things. And no, switching interrupts
won't help. It might be a band-aid but it's certainly not a model, and
it's totally useless for runtime PM.

> Me, I don't care. Happily, the whole point of open source is that you can =

> change things. So rather than waste time explaining myself to people who =

> can't admit that the current situation sucks, I'll just end up doing =

> something productive - namely "Just Do It".
> =

> I think it's a failure that I have to do things like that myself, but in =

> the end, I don't much care. I've fixed up USB and PCMCIA messes for the =

> same reasons in the past.
> =

> One day maybe it turns out that I'll be wrong. We'll see. I doubt it's =

> going to be this time.

So the whole point of open source is that you know better than everybod
who has ever actually worked on the problem & implemented successfully
suspend and resume, and thus will break everything for how many
monthes/year beyond repair just because you are right and everybody else
is wrong ?

Go for it, go. Looks like I won't upgrade the kernel on my latpop for a
while ...

Ben.
