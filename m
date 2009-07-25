From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] acer-wmi: switch driver to dev_pm_ops
Date: Sat, 25 Jul 2009 22:04:44 +0200
Message-ID: <200907252204.44875.rjw__13200.4297142432$1248552451$gmane$org@sisk.pl>
References: <1248527091-18246-1-git-send-email-arnaud.faucher@gmail.com>
	<20090725174311.GB14062@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090725174311.GB14062@dtor-d630.eng.vmware.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnaud Faucher <arnaud.faucher@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 25 July 2009, Dmitry Torokhov wrote:
> Hi Arnaud,
> 
> On Sat, Jul 25, 2009 at 09:04:51AM -0400, Arnaud Faucher wrote:
> > Gets rid of the following warning:
> > Platform driver 'acer-wmi' needs updating - please use dev_pm_ops
> > 
> 
> Have you tested it with Suspend to disk? You are [potentially] breaking
> it since the new suspend and resume methods are not used by it, it calls
> freeze() and thaw() instead.
> 
> Rafael,
> 
> I wonder if PM core should automatically use suspend()/resume() in place of
> freeze()/thaw() when the latter pair is missing.

Well, in fact it often is not necessary to do .thaw() at all, because the
state of the device doesn't change in .freeze().  Also, PCI drivers should
not need .thaw(), unless they manipulate the standard PM registers of the
device themselves.

That said, if .suspend() is defined, then most probably .freeze() is necessary
as well.  Also, if .resume() is defined, .restore() is most probably necessary
and it should be safe to use .suspend() as .freeze() and .resume() as
.restore().

OTOH, it's really easy to point .restore() to the same routine as .resume()
etc., so I'm not sure.

Best,
Rafael
