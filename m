From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: CPUFREQ/CPU-IDLE: Dynamic addition and removal driver
	P/C-states with constraints
Date: Fri, 27 Jul 2007 19:45:20 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290182BC7D@dlee13.ent.ti.com>
References: <200704051249.10407.david-b@pacbell.net><200707251304.03191.david-b@pacbell.net>
	<20070726070739.GB3901@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20070726070739.GB3901@inferi.kami.home>
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
Cc: "Dasu, Karthik P" <karthik-dp@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I was wondering if anyone had an opinion about dynamically changing the available p-states based on constraints.

The same thought goes for C-States with use with cpu-idle.

The governor at its next sample time would hopefully adjust asking within the range of what is left.

Recently Nokia talked about doing this at by changing policies this I think would be at a bit lower level.

Regards,
Richard W.
