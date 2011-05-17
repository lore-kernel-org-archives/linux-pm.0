From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm loss development
Date: Wed, 18 May 2011 01:10:52 +0200
Message-ID: <201105180110.52631.rjw__15962.1495790363$1305674123$gmane$org@sisk.pl>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
	<201105131854.57854.rjw@sisk.pl>
	<BANLkTi=0T_jmEju+cP8zG8EC0ns-mwKHYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=0T_jmEju+cP8zG8EC0ns-mwKHYw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, May 14, 2011, Raffaele Recalcati wrote:
> > I read the patches.  My question was about the general idea of who should
> > be responsible of making these decisions.
> 
> The best  should be, I think, to have some guidelines and than the
> possibility to choose the best policy for each situation.

Again, I'd like to know who's supposed to make the choice.

> In my board I needed to shutdown video in capture and demodulator
> circuit, so I have implemented vpfe capture switch off, that does
> stream_off to all its v4l2 subdevices (a pal decoder and a video
> demodulator).
> So I can save 30mA, and it allows to my board to survive longer.
> I need to do some tests and have some data with and without PM loss.

That's fine, but in general we need to take care of a few more things,
like the interactions between the devices we're switching off and user
space (that can be doing just about anything at the moment).

We can't simply switch off devices at will, because that may lead to
breakage too in general.

Thanks,
Rafael
