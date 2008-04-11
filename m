From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 1/4] Container Freezer: Add TIF_FREEZE
	flag to all	architectures
Date: Fri, 11 Apr 2008 13:49:30 +0200
Message-ID: <20080411114930.GB1740__35895.7807453864$1207914691$gmane$org@elf.ucw.cz>
References: <20080403210316.397506379@us.ibm.com>
	<20080403210316.659937801@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080403210316.659937801@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: matthltc@us.ibm.com
Cc: Linux Containers <containers@lists.linux-foundation.org>, Cedric Le Goater <clg@fr.ibm.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-04-03 14:03:17, matthltc@us.ibm.com wrote:
> This patch is the first step in making the refrigerator() available 
> to all architectures, even for those without power management. 
> 
> The purpose of such a change is to be able to use the refrigerator() 
> in a new control group subsystem which will implement a control group
> freezer.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> Tested-by: Matt Helsley <matthltc@us.ibm.com>
> Cc: linux-pm@lists.linux-foundation.org

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
