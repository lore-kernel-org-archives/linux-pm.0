From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/9] Suspend block api (version 4)
Date: Thu, 22 Apr 2010 21:39:40 -0700
Message-ID: <20100423043940.GB4198__33605.4023741328$1271998068$gmane$org@kroah.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1271984938-13920-1-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 22, 2010 at 06:08:49PM -0700, Arve Hj??nnev??g wrote:
> This patch series adds a suspend-block api that provides the same
> functionality as the android wakelock api. The code is mostly the
> same as version 3 posted last year, but the main entry point has
> changed back to /sys/power/state with a new /sys/power/policy to
> alter its behavior. Timeout support is not included in this initial
> patchset.

Yeah!  Thanks for respining this and pushing it out.  This should help
lots of drivers get merged after this is in-tree.

thanks again,

greg k-h
