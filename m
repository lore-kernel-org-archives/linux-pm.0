From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: PowerOP, Intro 0/3
Date: Tue, 29 Aug 2006 22:56:53 +0400
Message-ID: <acd2a5930608291156s399f01e9t767085bb6487aed8@mail.gmail.com>
References: <44ECFC0E.10803@gmail.com> <20060826082848.GC8538@elf.ucw.cz>
	<acd2a5930608260643o4061d1cfsf6eb4218f2ab7b0e@mail.gmail.com>
	<20060826135522.GA15009@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060826135522.GA15009@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hello Pavel,

On 8/26/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > >Workable solution would be to create power domains, and group devices
> > >into power domains.
> >
> > what do you mean by power domain here? Is a power domain a set of
> > arbitrary chosen devices?
>
> Basically, yes. Set of devices, where power/frequency transitions need
> to be coordinated between them.
>
> > Do you think "operating point" operating with power domains and not
> > devices directly is an acceptable solution for your laptop? :)
>
> I guess it would be more like many different powerops for independend
> pieces of hardware. And yes, that should work.

okay, this is just another layer of indirection which can be added
later. Why not reach a consensus here that PowerOP is basically fine,
probably needing to have power domain concept added (though there
might be some disagreement, I guess) and, consequently, start
integrating PowerOP into the mainline?

Vitaly
