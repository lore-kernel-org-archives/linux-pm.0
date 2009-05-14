From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm: rename device_power_down/up()
Date: Fri, 15 May 2009 01:11:01 +0200
Message-ID: <200905150111.01896.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0905141421130.4344-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0905141533260.24833@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0905141533260.24833@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Len Brown wrote:
> I agree with Alan,
> 
> ACK on the 1st patch,

Applied to the suspend tree.

> and lets follow it up so we're not in the funky state where we have
> both device_resume() and resume_device() etc. at the same time.

Works for me. :-)

Thanks,
Rafael
