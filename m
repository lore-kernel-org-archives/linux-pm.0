From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Info on hibernation swap space requirement
Date: Tue, 18 Nov 2008 09:59:30 +0100
Message-ID: <492283F2.1080000@st.com>
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
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi all.

I added the hibernation support on a sh4 based platform and it works fine,
 but I don't understand how big the swap space has to be.

My system has 64Mb and I was assuming, I can freeze ~32 Mb therefore
 I was creating a swap space of 40/50 Mb.

But it seems it isn't enough, the system is requiring more space.

Could you say me how evaluate the right (minimal) swap space required
 when I know the DRam memory size.

Regards
 Francesco
