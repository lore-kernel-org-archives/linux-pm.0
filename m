From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Dynamic Idle?
Date: Fri, 7 Nov 2008 10:54:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811071052050.2437-100000@iolanthe.rowland.org>
References: <345163910811070737y7de8a4bfoa401b632d1db3162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <345163910811070737y7de8a4bfoa401b632d1db3162@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Reid <ppeter.reid@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Nov 2008, Peter Reid wrote:

>   Do you mean to say that:
> 
>    Dynamic = Active
>    Idle = Idle
>    Suspend = Low Power State
>    Resume = Active/Dynamic

More like: Resume = High Power State.  Or better still:

	Suspend = Go to low-power state
	Resume = Return to high-power state

>   If so, what is the difference between suspend and Idle?

A suspended device must, of course, be idle.  But an idle device need
not be suspended.  A device can remain in a high-power state even while
it's not doing anything.

>   Are both the same and what are OFF State/Retention State as well?

Presumably "OFF state" means no power at all.  I don't know what 
"Retention State" means.

Alan Stern
