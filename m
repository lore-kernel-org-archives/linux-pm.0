From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pcmcia: db1xxx-ss: suspend/resume fix
Date: Tue, 23 Mar 2010 23:02:49 +0100
Message-ID: <201003232302.49415.rjw@sisk.pl>
References: <1269287003-15523-1-git-send-email-manuel.lauss@gmail.com>
	<20100322205814.GB15250@isilmar.linta.de>
	<f861ec6f1003231015j73d6de9dp7a3a4e087aabda0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f861ec6f1003231015j73d6de9dp7a3a4e087aabda0a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Manuel Lauss <manuel.lauss@googlemail.com>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.linux-foundation.org, linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 March 2010, Manuel Lauss wrote:
> Howdy,
> 
> On Mon, Mar 22, 2010 at 9:58 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > Hm, what about using two commits currently in my tree for 2.6.36 instead,
> > which should fix all socket drivers?
> >
> >    power: support _noirq actions on device types and classes
> >    pcmcia: use dev_pm_ops for class pcmcia_socket_class
> >
> > Manuel: Could you try whether they also solve these issues? If so, I'd
> 
> Yes it does, works on my MIPS test systems.

I don't seem to have received the original message, so sorry for the lack of
response.
 
> > propose pushing both patches already for 2.6.36. Rafael: do you concur?

I do.  The patches look good and if they fix things for people right now,
that's a good reason to push them for .34.

> I hope you meant 2.6.34

I think Dominik meant .35 actually.

Rafael
