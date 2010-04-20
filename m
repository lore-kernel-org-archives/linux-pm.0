From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Reordering of dpm_list?
Date: Tue, 20 Apr 2010 20:58:49 +0200
Message-ID: <201004202058.49617.rjw@sisk.pl>
References: <201004201643.12274.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004201643.12274.oliver@neukum.org>
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

On Tuesday 20 April 2010, Oliver Neukum wrote:
> Hi,
> 
> I am seeing rare problems with rfkill waking up before its assigned
> btusb. Is something rearranging dpm_list in recent kernels? 2.6.32 onwards?

Not that I know of right now, but it's possible.

However, I think most likely the ordering of device registration is not correct
somewhere.

Rafael
