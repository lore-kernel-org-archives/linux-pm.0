From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pcmcia: db1xxx-ss: suspend/resume fix
Date: Wed, 24 Mar 2010 21:03:21 +0100
Message-ID: <201003242103.21659.rjw__7047.6247267381$1269460976$gmane$org@sisk.pl>
References: <1269287003-15523-1-git-send-email-manuel.lauss@gmail.com>
	<20100324191844.GA22767@isilmar.linta.de>
	<f861ec6f1003241223v11e3eaf3sf4e2c0a7594a38df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f861ec6f1003241223v11e3eaf3sf4e2c0a7594a38df@mail.gmail.com>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 March 2010, Manuel Lauss wrote:
> On Wed, Mar 24, 2010 at 8:18 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > Hey,
> >
> > On Wed, Mar 24, 2010 at 06:04:50PM +0100, Manuel Lauss wrote:
> >> Dominik,
> >>
> >> On Tue, Mar 23, 2010 at 11:02 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Tuesday 23 March 2010, Manuel Lauss wrote:
> >> >> Howdy,
> >> >>
> >> >> On Mon, Mar 22, 2010 at 9:58 PM, Dominik Brodowski
> >> >> <linux@dominikbrodowski.net> wrote:
> >> >> > Hm, what about using two commits currently in my tree for 2.6.36 instead,
> >> >> > which should fix all socket drivers?
> >> >> >
> >> >> >    power: support _noirq actions on device types and classes
> >> >> >    pcmcia: use dev_pm_ops for class pcmcia_socket_class
> >> >> >
> >> >> > Manuel: Could you try whether they also solve these issues? If so, I'd
> >> >>
> >> >> Yes it does, works on my MIPS test systems.
> >> >
> >> > I don't seem to have received the original message, so sorry for the lack of
> >> > response.
> >> >
> >> >> > propose pushing both patches already for 2.6.36. Rafael: do you concur?
> >> >
> >> > I do.  The patches look good and if they fix things for people right now,
> >> > that's a good reason to push them for .34.
> >> >
> >> >> I hope you meant 2.6.34
> >> >
> >> > I think Dominik meant .35 actually.
> >>
> >> Okay, can we apply my v2 patch to 2.6.34?  I'd like to have PM working when
> >> it gets out.
> >
> > Actually I meant .34. I'll push out my patch in the next days, if you
> > concur.
> 
> Great, I'm all for upstreaming your patch.

Agreed.

Rafael
