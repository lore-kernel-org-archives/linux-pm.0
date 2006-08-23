From: Mark Gross <mgross@linux.intel.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 23 Aug 2006 11:50:44 -0700
Message-ID: <20060823185044.GA22525@linux.intel.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060820033044.GA24928@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 19, 2006 at 11:30:44PM -0400, Dave Jones wrote:
> On Sat, Aug 19, 2006 at 08:20:45PM -0700, David Singleton wrote:
> =

>  > If I had all the existing cpufreq tables transformed
>  > into operating points I could make a patch that would remove
>  > the bulk of cpufreq code from the kernel and you'd have
>  > pretty much the same functionality without the maintenance
>  > issues the added layers and complexity bring.
> =

> If this is going to fly at all, I think thats where we need to be headed.
> Having two parts of the kernel doing the same thing just seems
> very wrong to me.
> =

> The other alternative as suggested earlier this week would be archictures
> getting to 'opt out' of powerop for their cpufreq drivers where it doesn't
> necessarily bring anything but the layer of indirection.
> =

> I'm about to disappear for two weeks for a much needed vacation, but
> I'll be interested to see other folks comments/opinions on this
> when I get back.

I worry about all the users of ondemand and powernow.  Whatever
happens it needs to be a evolve over time.  I don't know how you can
have only one power solution that works for HPC and embedded.

> =

> 		Dave
> =

> -- =

> http://www.codemonkey.org.uk
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
