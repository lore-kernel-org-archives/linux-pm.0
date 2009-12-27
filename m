From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFT] Input: speed up suspend/shutdown for PS/2 mice
 and keyboards
Date: Sun, 27 Dec 2009 02:10:41 -0800
Message-ID: <20091227101041.GD14655__36241.4488954984$1261908720$gmane$org@core.coreip.homeip.net>
References: <20091221070951.GA4170@core.coreip.homeip.net>
	<20091227002658.GB26593@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091227002658.GB26593@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 26, 2009 at 10:26:58PM -0200, Henrique de Moraes Holschuh wrote:
> Works on my ThinkPad T43 (KBC emulated by the embedded controller firmware),
> although I don't think it made much difference in speed.
> 

Thanks. The speedup should not be that noticeable (even worst hardware
usually manages to do full reset in 0.5 sec), still 0.5 sec here and 0.5
sec there may add up.

-- 
Dmitry
