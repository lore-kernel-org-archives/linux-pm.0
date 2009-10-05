From: "Premi, Sanjeev" <premi@ti.com>
Subject: [RFC]cpuidle: Incorrect statistics
Date: Mon, 5 Oct 2009 19:56:41 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDC08B8D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,
 
While testing the cpuidle on the OMAP3 platform, I observed
that the usage statistics did not match the actual idle
state transitions. This was happening due to two reasons:

1) The menu governor is selecting a "deep" idle state that
   cannot be attained. The system is able to attain one of
   the higher states; however, the statistics get updated
   for the "originally" selected state.

2) Some of the deep states can be defined as "invalid" at
   run-time via a sysfs entry "enable_off_mode". The since
   argument passed into the "enter_idle()" is pointer to
   the state selected by governor, it is possble to reach
   an invalid state.

I am suggesting the following:

1) An additional flag for each idle state "valid".
   Any change in the "valid" flag is reflected back.

2) Governor takes this flag into account before selecting
   a target idle state.

Looking for comments/suggestions.

Here are link to this discussion on the linux-omap list:
 - http://marc.info/?l=linux-omap&m=125214460417989&w=2
 - http://marc.info/?l=linux-omap&m=125260684907329&w=2
 - http://marc.info/?l=linux-omap&m=125423861614898&w=2
 
Best regards,
Sanjeev
