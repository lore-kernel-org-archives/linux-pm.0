From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 0/3] experimental G5 powermac suspend implementation
Date: Tue, 12 Dec 2006 00:02:08 +0100
Message-ID: <42760.8710634106$1165923019@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>
List-Id: linux-pm@vger.kernel.org

This is a rather hacky suspend implementation for G5s.

I'm only posting it for the fun of it and because it makes no sense to
continue sitting on it (I've had parts of this code more than half a year
ago...)

Don't blame me if it breaks your machine, filesystems or similar :)

johannes
