From: deepaksi <deepak.sikri@st.com>
Subject: Suspend to RAm query
Date: Tue, 28 Jun 2011 19:28:27 +0530
Message-ID: <4E09DE03.3090100@st.com>
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
To: linux-pm@lists.linux-foundation.org, deepak.sikri79@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi All,

I have a very basic query w.r.t the place to handle the standby/suspend
process for the devices in the system.

Should it be done at the driver level or in the machine/platform
specific code ?

There are instances where I need some specific functionality in the
standby mode, or some extra functionality
in the suspend mode at the device level. Is that the reason for
differentiating between the suspend and standby at
the platform code level, because in platform code we get different
states signifying a suspend or a standby ?

Thanks
Deepak
