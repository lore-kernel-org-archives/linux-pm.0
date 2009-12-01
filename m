From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Async serio suspend/resume?
Date: Tue, 1 Dec 2009 15:10:09 -0800
Message-ID: <20091201231008.GB20335@core.coreip.homeip.net>
References: <200912012355.49050.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912012355.49050.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Dec 01, 2009 at 11:55:48PM +0100, Rafael J. Wysocki wrote:
> Hi Dmitry,
> 
> Do you think it would be safe to allow serio devices to use the async
> suspend/resume now?
> 

Should be fine now, although I would not enable it in .32. But .33 seems
like a good target.

-- 
Dmitry
