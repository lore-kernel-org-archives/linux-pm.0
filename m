From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Null suspend/resume functions
Date: Tue, 17 Nov 2009 23:14:04 +0100
Message-ID: <200911172314.04396.rjw__17145.6296615817$1258496137$gmane$org@sisk.pl>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<aec7e5c30911170446n71031671i48aca11f5276405d@mail.gmail.com>
	<20091117125901.GF823@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091117125901.GF823@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 17 November 2009, Mark Brown wrote:
> On Tue, Nov 17, 2009 at 09:46:35PM +0900, Magnus Damm wrote:
> 
> > On SuperH we have Runtime PM enabled on a few platforms together with
> > a few updated drivers. The latest driver to become more power aware is
> > this FSI driver.
> 
> I understand exactly what the runtime PM stuff and the driver are doing
> here, the issue is the mandatory suspend and resume functions.
> 
> > At this point the SuperH specific platform bus code requires the
> > callbacks ->runtime_suspend() and ->runtime_resume() to be present. It
> > may be a good idea to allow them to be NULL in the future or maybe
> > having some shared functions, but before starting to break out stuff
> > I'd like to see how other Runtime PM implementations deal with this.
> > So unless people object I prefer to keep it as-is for now.
> 
> What is the reason for requiring that the driver provide stub functions?
> For me the issue is that if it's mandatory for the driver to provide the
> functions then having stub functions in there makes the driver look like
> it is abusing the API by not implementing mandatory functionality.

In fact, it's not mandatory for bus types, not for drivers.  IMO bus types
really have to know how to suspend a device and how to resume it,
otherwise the core framework won't be useful anyway.  What the bus type does
about drivers not implementing ->runtime_suspend() or ->runtime_resume(), it's
up to the bus type.  That's even documented IIRC.

Thanks,
Rafael
