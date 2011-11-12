From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: e978aa7d (cpuidle: Move dev->last_residency
	update...) broke suspend
Date: Sat, 12 Nov 2011 02:18:17 +0100
Message-ID: <201111120218.17758.rjw@sisk.pl>
References: <874nyadwef.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <874nyadwef.fsf@tac.ki.iif.hu>
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
Cc: Ferenc Wagner <wferi@niif.hu>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, November 12, 2011, Ferenc Wagner wrote:
> Hi,
> 
> Since e978aa7d (cpuidle: Move dev->last_residency update to driver
> enter routine; remove dev->last_state) my ThinkPad R50e can't suspend
> anymore, it just freezes instead.  I controlled git bisect by booting
> with break=top and issuing 'echo mem >/sys/power/state'.  My config is
> attached.

What's the output of "cat /sys/devices/system/cpu/cpuidle/current_driver" ?

Rafael
