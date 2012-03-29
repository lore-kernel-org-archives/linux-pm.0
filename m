From: Zhichao Li <lzcmichael@gmail.com>
Subject: Regarding CPU idle C states
Date: Thu, 29 Mar 2012 16:58:10 -0400
Message-ID: <CAOUN_DfbAAsAmySTOQ_-zQLbFnCEOnvSsjdXevs9OBXkAgGCUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I am a third year PhD student working on power management in storage
systems, under the Linux platform.

We are exploring CPU DVFS, and also idle CPU C states. We figured out
that the scheduling of CPU frequencies is exported to user level with
the "userspace" governor. However, it seems the multiple idle C states
are only scheduled in the kernel space (governors like "menu" and
"ladder").

We wonder whether there is any existing kernel module or existing
kernel patch that can export the various idle CPU C states to the user
level for user's control as well.  If you could guide us to such
code/patch, or if you have plan to do so, we'd be more than happy to
help you testing the code for various idle CPU C states in the user
level.

Thanks for your time. Appreciated it!

Regards,

-- 
Zhichao Li
File Systems and Storage Lab
Computer Science Department
Stony Brook University
