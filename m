From: Simon Horman <horms@verge.net.au>
Subject: PM QoS: Interface design question
Date: Tue, 22 Feb 2011 15:30:10 +0900
Message-ID: <20110222062944.GA5125@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Mark Gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I am curious about an aspect of the design of PM QoS.

While working with the devices provided to configure PM QoS it struck me
that this is a rather unusual interface - holding a file descriptor to a
device open so long as configuration parameters apply.  I understand that
this is a mechanism to apply parameters on a per-task basis.  But I am
wondering if any consideration was given to using cgroups, which seem to me
to be designed specifically for applying QoS parameters on a per-task
basis.
