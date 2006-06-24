From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Sat, 24 Jun 2006 19:16:43 +0200
Message-ID: <200606241916.43892.rjw@sisk.pl>
References: <4499BE99.6010508@gmail.com> <20060623221117.GA2497@elf.ucw.cz>
	<20060623235357.GA1181@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060623235357.GA1181@slug>
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
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-pm@osdl.org, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 24 June 2006 01:53, Frederik Deweerdt wrote:
> On Sat, Jun 24, 2006 at 12:11:18AM +0200, Pavel Machek wrote:
> > On Fri 2006-06-23 20:41:01, Russell King wrote:
> > > On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> > > > Serial console is currently broken by suspend, resume. _But_ I have=
 a
> > > > patch I'd like you to try.... pretty please?
> > > =

> > > Did you bother trying my patch, which was done the Right(tm) way?
> > > There wasn't any feedback on it so I can only assume not.
> > =

> > (I actually forwarded him your patch in private email).
> And I did try it, but it make no difference: the output would still
> appear on the laptop.

You can try to use the hack at
http://www.sisk.pl/kernel/patches/2.6.17-mm1/hack-serial-suspend.patch
and see if that makes the messages get to the serial console.

Greetings,
Rafael
