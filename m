From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v2] pcmcia: db1xxx-ss: suspend/resume fix
Date: Tue, 23 Mar 2010 18:15:36 +0100
Message-ID: <f861ec6f1003231015j73d6de9dp7a3a4e087aabda0a@mail.gmail.com>
References: <1269287003-15523-1-git-send-email-manuel.lauss@gmail.com>
	<20100322205814.GB15250@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100322205814.GB15250@isilmar.linta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Manuel Lauss <manuel.lauss@googlemail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pcmcia@lists.infradead.org, Manuel Lauss <manuel.lauss@gmail.com>, linux-pm@l
List-Id: linux-pm@vger.kernel.org

Howdy,

On Mon, Mar 22, 2010 at 9:58 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Hm, what about using two commits currently in my tree for 2.6.36 instead,
> which should fix all socket drivers?
>
> =A0 =A0power: support _noirq actions on device types and classes
> =A0 =A0pcmcia: use dev_pm_ops for class pcmcia_socket_class
>
> Manuel: Could you try whether they also solve these issues? If so, I'd

Yes it does, works on my MIPS test systems.


> propose pushing both patches already for 2.6.36. Rafael: do you concur?

I hope you meant 2.6.34


Thanks!
     Manuel Lauss
