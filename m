From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.21-mm1+hotfix -- Time gets confused during resume
	from suspend (18014554.415987)
Date: Mon, 7 May 2007 12:13:30 -0700
Message-ID: <a44ae5cd0705071213md3a403bk3b4b6686a7e333db__38313.2128198214$1178565370$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[ 1278.513048] agpgart-intel 0000:00:00.0: LATE suspend
[ 1278.513791]  hwsleep-0323 [03] enter_sleep_state     : Entering
sleep state [S3]
[18014554.415987] Intel machine check architecture supported.
[18014554.416010] Intel machine check reporting enabled on CPU#0.
[18014554.416050] Back to C!
[ 1281.221504] agpgart-intel 0000:00:00.0: EARLY resume
[ 1281.221508] PCI: Calling quirk c01cbfe6 for 0000:00:00.0
[ 1281.221510] pci 0000:00:00.1: EARLY resume
[ 1281.221513] PCI: Calling quirk c01cbfe6 for 0000:00:00.1
