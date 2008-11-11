From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: Dynamic Idle?
Date: Tue, 11 Nov 2008 15:51:16 +0200
Message-ID: <20081111135116.GA18652@everest.verdurent.com>
References: <345163910811070737y7de8a4bfoa401b632d1db3162@mail.gmail.com>
	<Pine.LNX.4.44L0.0811071052050.2437-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0811071052050.2437-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 07, 2008 at 10:54:58AM -0500, Alan Stern wrote:
> On Fri, 7 Nov 2008, Peter Reid wrote:
>
> >   Are both the same and what are OFF State/Retention State as well?
> 
> Presumably "OFF state" means no power at all.  I don't know what 
> "Retention State" means.

"Retention state" is used in some embedded architectures to mean a low-power state of the processor where context is maintained. e.g. Putting RAM in self refresh mode, so that devices do not have to initialise themselves when coming out of the low-power state.

/Amit

-- 
-------------------------------------------------------------------------
Amit Kucheria			amit.kucheria@verdurent.com
Kernel Developer, Verdurent
--------------------------------------------------------------------------
