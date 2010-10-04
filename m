From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Mon, 4 Oct 2010 11:38:49 -0700
Message-ID: <20101004183848.GG8321__33554.8883690082$1286218589$gmane$org@core.coreip.homeip.net>
References: <4C8E180D.4020309@suse.cz> <201009140807.39977.oliver@neukum.org>
	<20101004161320.GA14180@core.coreip.homeip.net>
	<201010042033.53453.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201010042033.53453.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, pingc@wacom.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 04, 2010 at 08:33:53PM +0200, Oliver Neukum wrote:
> Am Montag, 4. Oktober 2010, 18:13:20 schrieb Dmitry Torokhov:
> > Lost track of this issue for a while. So I think we still need to fix
> > the deadlock for .36 and I think that the following will do that. Then
> > we'll adjust the driver to actually enable runtime PM for .37.
> 
> That's a viable plan.
> 

I take it as an "acked-by" for this patch, right?

-- 
Dmitry
