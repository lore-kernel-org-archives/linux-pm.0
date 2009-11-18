From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Null suspend/resume functions
Date: Wed, 18 Nov 2009 17:09:08 +0100
Message-ID: <20091118160908.GD20887__22566.0336822786$1258560776$gmane$org@elf.ucw.cz>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
	<20091117115236.GB1376@ucw.cz>
	<20091117124125.GD823@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091117124125.GD823@rakim.wolfsonmicro.main>
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2009-11-17 12:41:25, Mark Brown wrote:
> On Tue, Nov 17, 2009 at 12:52:36PM +0100, Pavel Machek wrote:
> 
> > I believe that having few nop functions around the tree should not be
> > huge problem. If it is, you can introduce one shared top function into
> > the core...
> 
> The problem I have with that is that for most APIs noop functions are a
> big fat warning sign that something is going wrong and the API is being
> abused.  This then creates noise and code review problems in the driver
> code since you've got something that normally suggests a problem.

That still sounds like poor reason to add tests to core. But return 0
function for that purpose should be ok (and should make code easy to
review, too).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
