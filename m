From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc4-mm1
Date: Tue, 20 Mar 2007 15:31:02 +0100
Message-ID: <45FFF026.4030502@gmail.com>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933504AbXCTObX@vger.kernel.org>
In-Reply-To: <20070319205623.299d0378.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Andrew Morton napsal(a):
>   http://userweb.kernel.org/~akpm/2.6.21-rc4-mm1/

I'm getting this while trying to swsusp:
Stopping tasks ...
Stopping kernel threads timed out after 20 seconds (1 tasks refusing to freeze):
 swapper
 Restarting tasks ... done.

What to test? Enable PM_DEBUG?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
