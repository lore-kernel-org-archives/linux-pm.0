From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: LCDC problem after commit
	794d78fea51504bad3880d14f354a9847f318f25
Date: Mon, 8 Aug 2011 10:46:26 +0900
Message-ID: <CANqRtoTF+CmjgRyqusAw5G4JZg99RwfaD8s8RA8CB63o_otSyw__12886.909224517$1312768052$gmane$org@mail.gmail.com>
References: <201108080125.34329.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108080125.34329.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, Aug 8, 2011 at 8:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Unfortunately, after commit 794d78fea51504bad3880d14f354a9847f318f25
> (drivers: sh: late disabling of clocks V2) the LCDC screen on my
> Mackerel board goes off (late) during boot and cannot be turned on
> by any way AFAICS (the backlight remains on, though).
>
> It looks like the late disabling of clocks interacts badly with the
> clock management done by PM domains.

This is most likely showing a so-far-not-handled clock dependency for
the LCDC hardware. I'll have a look.

Thanks,

/ magnus
