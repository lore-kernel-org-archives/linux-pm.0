From: Jim Rees <rees@umich.edu>
Subject: Re: WARNING: at kref_get
Date: Fri, 11 Mar 2011 15:23:22 -0500
Message-ID: <20110311202322.GB4146@merit.edu>
References: <20110310054945.GB3058@merit.edu> <201103101139.58837.rjw@sisk.pl>
	<20110311012246.GA1115@merit.edu> <201103112104.51710.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103112104.51710.rjw@sisk.pl>
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

  PCMCIA resume problem have been reported already, but the root cause is
  unknown.  It looks like the driver's resume callback is never executed.

Thank you, if I get any more info on the kref_get problem I'll let you know.
