From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Info on EHCI/OHCI vs PM
Date: Mon, 08 Sep 2008 08:18:45 +0200
Message-ID: <48C4C3C5.4000503@st.com>
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

Hi all.
I need an help on USB vs PM.
I'm working on a embedded platform with USB Host Controller.
There is an EHCI with a Companion OHCI and both work fine.
Now I would add the PM support.
Until now both the host controller are on the 'platform_bus' therefore 
they seem
 independent.

Is this configuration ok or I have to declare a kind of relationship
 between the host controller (and if so which one)?

Regards
 Francesco
