From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 16:27:18 +0300
Message-ID: <1157030838.10909.144.camel@localhost>
References: <20060814200735.GC14099@kroah.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<c55240ed0608271354o7224c903l8b9eae6de22ca8c6@mail.gmail.com>
	<b324b5ad0608281829t66bb3060r9fda9fc08841b51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b324b5ad0608281829t66bb3060r9fda9fc08841b51@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext David Singleton <daviado@gmail.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2006-08-28 at 18:29 -0700, ext David Singleton wrote:

> >
> > - latency is not an attribute of a certain operating point but a
> function of
> > two arguments - current operating point and a point we are goint to
> > switch to. Therefor latency just does not belong to 'struct powerop'
> =

> I disagree.

Problem is that you disagree without giving your reasons. Here is
another reason putting latency into your operating point definition
isn't going to fly:

http://lwn.net/Articles/196900/ <--- An API for specifying latency
constraints

http://lwn.net/Articles/197282/

Please comment on PowerOP patches; dissect them if need be on why you
don't agree with the approach.

Regards,
Amit

-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
