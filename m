From: Jim Rees <rees@umich.edu>
Subject: Re: WARNING: at kref_get
Date: Thu, 10 Mar 2011 20:22:46 -0500
Message-ID: <20110311012246.GA1115@merit.edu>
References: <20110310054945.GB3058@merit.edu> <201103101139.58837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103101139.58837.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:

  On Thursday, March 10, 2011, Jim Rees wrote:
  > Was there ever a resolution to this bug?
  
  Do you still see the warning in 2.6.38-rc8?

I won't be able to test it, rc8 is unusable for other reasons.  My
orinoco_cs won't resume after suspend.  I put a dmesg here in case you're
interested:

http://jim.rees.org/x40-38-rc8.log
