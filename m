From: Oliver Neukum <oliver@neukum.name>
Subject: question on wake_up() in suspend() and resume()
Date: Wed, 31 Jan 2007 09:24:32 +0100 (MET)
Message-ID: <200701310924.43333.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

could someone please summarize under which conditions a driver
may call wake_up() in suspend() and resume(). This is for a driver
which has IO queued for output. WHen may the tasks doing the IO
be notified about completion of IO?

	Regards
		Oliver
