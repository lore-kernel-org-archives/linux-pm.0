From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] cpuidle: menu governor: reduce latency on
	exit
Date: Thu, 23 Jul 2009 15:05:17 -0700
Message-ID: <20090723150517.fbbd03dc.akpm__38037.2388558046$1248386861$gmane$org@linux-foundation.org>
References: <200907191659.47179.czoccolo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907191659.47179.czoccolo@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: linux-kernel@vger.kernel.org, abelay@novell.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 19 Jul 2009 16:59:46 +0200
Corrado Zoccolo <czoccolo@gmail.com> wrote:

> This patch moves the state residency accounting and statistics
> computation off the hot exit path.
> On exit, the need to recompute statistics is recorded, and new
> statistics will be computed when menu_select is called again.
> 

Was there any observed and/or measured effect as a result of this patch?

If so, please send a description of that effect, thanks.
