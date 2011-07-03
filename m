From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAm query
Date: Sun, 3 Jul 2011 09:04:08 +0200
Message-ID: <201107030904.08190.rjw__34047.6506892175$1309676667$gmane$org@sisk.pl>
References: <4E09DE03.3090100@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E09DE03.3090100@st.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: deepak.sikri79@gmail.com
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, deepaksi <deepak.sikri@st.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, June 28, 2011, deepaksi wrote:
> Hi All,
> 
> I have a very basic query w.r.t the place to handle the standby/suspend
> process for the devices in the system.
> 
> Should it be done at the driver level or in the machine/platform
> specific code ?
> 
> There are instances where I need some specific functionality in the
> standby mode, or some extra functionality
> in the suspend mode at the device level. Is that the reason for
> differentiating between the suspend and standby at
> the platform code level, because in platform code we get different
> states signifying a suspend or a standby ?

Yes, it is.

The platform suspend callbacks in strcut platform_suspend_ops (as defined
in include/linux/suspend.h) take a suspend_state_t argument indicating
what state is being requested.  You can get the information from there,
if I understood your problem description correctly.

Thanks,
Rafael
