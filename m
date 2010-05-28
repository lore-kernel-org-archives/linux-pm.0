From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
 driver for select intel processors
Date: Fri, 28 May 2010 15:51:01 -0400
Message-ID: <1275076262.12653.7.camel__21376.0586957962$1275076320$gmane$org@cndougla-ubuntu>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
	<1275013933.2312.7.camel@cndougla-ubuntu>
	<alpine.LFD.2.00.1005272359510.24823@localhost.localdomain>
	<1275059380.5612.60.camel@cndougla-ubuntu>
	<alpine.LFD.2.00.1005281343060.4045@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005281343060.4045@localhost.localdomain>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-05-28 at 13:43 -0400, Len Brown wrote:
> Atom C4 works in the current driver in the git tree -- test it now!

Sadly, it seems this isn't helping much. My netbook still idles at ~60
centigrade on and off power. I will verify that before this change I was
able to idle cooler when off power just to be sure.

I do see the C4 state both on and off power, so that's nice at least.
I'm just perplexed why my netbook runs so hot when idle. I even killed X
to see if it was really the gpu that was heating everything inside up,
but it didn't change anything.

-- Chase
