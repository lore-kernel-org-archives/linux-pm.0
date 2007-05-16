From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: 2.6.22-rc1 suspend to RAM problem
Date: Wed, 16 May 2007 15:34:42 +0200
Message-ID: <200705161534.42740.rjw@sisk.pl>
References: <f2evir$8n1$1@sea.gmane.org> <f2f02b$a47$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f2f02b$a47$1@sea.gmane.org>
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
Cc: linux-pm@lists.osdl.org, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 16 May 2007 15:13, Marcus Better wrote:
> Marcus Better wrote:
> > my Thinkpad R60 (x86_64, SMP, XFS) has failed to resume from RAM twice,
> 
> I should probably add that I have applied the Rafael's patch [1] for the
> suspend-to-disk issue.

Please revert it.  It's a debug-only patch and it fiddles with too many things.

Does the hibernation work with it, BTW?

Rafael
