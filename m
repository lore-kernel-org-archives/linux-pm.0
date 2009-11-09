From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Massive ext4 filesystem corruption after a failed
 s2disk/ram cycle
Date: Mon, 9 Nov 2009 07:42:03 -0200
Message-ID: <20091109094203.GA10007__22963.0375667059$1257759857$gmane$org@khazad-dum.debian.net>
References: <87vdisq7bh.fsf@rimspace.net>
	<20091007161604.GA28849@infradead.org>
	<20091104111125.54C3.A69D9226@jp.fujitsu.com>
	<20091108082905.GA25494@discord.disaster>
	<20091108164913.GA12053@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091108164913.GA12053@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Pittman <daniel@rimspace.net>, Dave Chinner <david@fromorbit.com>, linux-kernel <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 08 Nov 2009, Christoph Hellwig wrote:
> IMHO the best option is to have a separate partition for /boot with a
> very simple filesystem that we can expect boot loader developers to
> implement fully and correctly.

Agreed.  And one that is not all but abandoned kernel-side, or you will risk
bugs there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
