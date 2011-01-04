From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Question about timers during system suspend
Date: Wed, 5 Jan 2011 02:44:58 +0530
Message-ID: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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



Hi,
 
I have question regarding the timers during system suspend. If a software timer is
active in device driver, will this timer be stopped during system suspend?
 
If the timer is active, will it prevent the system from full suspend?
 
The another thing is during system suspend, how the user space code know about suspend?
 
One way is that device driver gets the suspend and it notifies the user space. 
 
But is there way that during system goes into full suspend, is any user space component that will
give notifications to applications that has registered for system suspend transition?
 
 
Regards
Raj 		 	   		  
