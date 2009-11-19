From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Null suspend/resume functions
Date: Thu, 19 Nov 2009 11:21:03 +0000
Message-ID: <20091119112102.GF9763__23023.1157890104$1258743824$gmane$org@rakim.wolfsonmicro.main>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
	<20091117115236.GB1376@ucw.cz>
	<20091117124125.GD823@rakim.wolfsonmicro.main>
	<20091118160908.GD20887@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091118160908.GD20887@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 18, 2009 at 05:09:08PM +0100, Pavel Machek wrote:
> On Tue 2009-11-17 12:41:25, Mark Brown wrote:

> > The problem I have with that is that for most APIs noop functions are a
> > big fat warning sign that something is going wrong and the API is being
> > abused.  This then creates noise and code review problems in the driver
> > code since you've got something that normally suggests a problem.

> That still sounds like poor reason to add tests to core. But return 0
> function for that purpose should be ok (and should make code easy to
> review, too).

What makes you believe that this is a poor reason?  The issue isn't that
the driver code is complex, the issue is that it's noise in the driver
which suggests that the driver isn't doing something it's supposed to
do.
