From: Chris Lapa <chris@lapa.com.au>
Subject: BQ27xxx registers
Date: Tue, 20 Dec 2016 17:00:41 +1100
Message-ID: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------024D8062C2B93B8D75CAB8AB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------024D8062C2B93B8D75CAB8AB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm testing out the 4.9 kernel on a AM3359 board fitted with a 
BQ27510-G3 fuel gauge. The board previously worked on the 4.1 kernel, 
however on the 4.9 kernel the bq27xxx_battery.c driver is spitting out 
this error continuously:

power_supply bq27510-0: driver failed to report `charge_full_design' 
property: -121

I have narrowed down the problem to commit 099867a16 where the 
BQ27XXX_REG_DCAP value was changed from 0x2e to 0x3c.

I can generate a patch to fix this issue, however the bigger problem 
exists as to which revision fuel gauge the bq27xxx_battery.c driver is 
intended to support for each family.

Attached is a table I put together of all the register addresses for 
each supported device under the BQ27500 definition and what the current 
driver utilizes (I didn't paste it here as the word wrapping messes with 
the formatting).

There isn't really an ideal solution I can see where we keep the single 
BQ27500 definition and support all the functionality of each revision.

We can try and just support the latest revisions (BQ27510-G3 and 
BQ27520-G4) but I think it could hurt backwards compatibility for 
existing hardware.

I'm happy to work on a fix but just wanted to get some thoughts before 
proceeding.

Cheers,
Chris

--------------024D8062C2B93B8D75CAB8AB
Content-Type: text/plain; charset=UTF-8;
 name="BQ275xx-Gx.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="BQ275xx-Gx.txt"

UmVnaXN0ZXIJCUJRMjc1MDAvMQlCUTI3NTEwLUcxCUJRMjc1MTAtRzIJQlEyNzUxMC1HMwlC
UTI3NTIwLUcxCUJRMjc1MjAtRzIJQlEyNzUyMC1HMwlCUTI3NTIwLUc0IAlicTI3eHh4X2Jh
dHRlcnkuYwpCUTI3WFhYX1JFR19DVFJMCTB4MDAJCTB4MDAJCTB4MDAJCTB4MDAJCTB4MDAJ
CTB4MDAJCTB4MDAJCTB4MDAJCTB4MDAKQlEyN1hYWF9SRUdfVEVNUAkweDA2CQkweDA2CQkw
eDA2CQkweDA2CQkweDA2CQkweDA2CQkweDA2CQkweDA2CQkweDA2CkJRMjdYWFhfUkVHX0lO
VF9URU1QCeKAlAkJLQkJLQkJMHgyOAkJLQkJMHgzNgkJMHgzNgkJMHgyOAkJMHgyOApCUTI3
WFhYX1JFR19WT0xUCTB4MDgJCTB4MDgJCTB4MDgJCTB4MDgJCTB4MDgJCTB4MDgJCTB4MDgJ
CTB4MDgJCTB4MDgKQlEyN1hYWF9SRUdfQUkJCTB4MTQJCTB4MTQJCTB4MTQJCTB4MTQJCTB4
MTQJCTB4MTQJCTB4MTQJCTB4MTQJCTB4MTQKQlEyN1hYWF9SRUdfRkxBR1MJMHgwYQkJMHgw
YQkJMHgwYQkJMHgwYQkJMHgwYQkJMHgwYQkJMHgwYQkJMHgwYQkJMHgwYQpCUTI3WFhYX1JF
R19UVEUJCTB4MTYJCTB4MTYJCTB4MTYJCTB4MTYJCTB4MTYJCTB4MTYJCTB4MTYJCTB4MTYJ
CTB4MTYKQlEyN1hYWF9SRUdfVFRGCQkweDE4CQkweDE4CQkweDE4CQnigJQJCTB4MTgJCTB4
MTgJCS0JCS0JCS0KQlEyN1hYWF9SRUdfVFRFUwkweDFjCQkweDFjCQkweDFjCQkweDFhCQkw
eDFjCQkweDFjCQkweDFjCQkweDFhCQkweDFhCkJRMjdYWFhfUkVHX1RURUNQCTB4MjYJCTB4
MjYJCTB4MjYJCS0JCTB4MjYJCTB4MjYJCTB4MjYJCS0JCS0KQlEyN1hYWF9SRUdfTkFDCQkw
eDBjCQkweDBjCQkweDBjCQkweDBjCQkweDBjCQkweDBjCQkweDBjCQkweDBjCQkweDBjCkJR
MjdYWFhfUkVHX0ZDQwkJMHgxMgkJMHgxMgkJMHgxMgkJMHgxMgkJMHgxMgkJMHgxMgkJMHgx
MgkJMHgxMgkJMHgxMgpCUTI3WFhYX1JFR19DWUNUCTB4MmEJCTB4MmEJCTB4MmEJCTB4MWUJ
CS0JCTB4MmEJCTB4MmEJCTB4MWUJCTB4MmEKQlEyN1hYWF9SRUdfQUUJCTB4MjIJCTB4MjIJ
CTB4MjIJCS0JCTB4MjIJCTB4MjIJCTB4MjIJCS0JCS0KQlEyN1hYWF9SRUdfU09DCQkweDJj
CQkweDJjCQkweDJjCQkweDIwCQkweDJjCQkweDJjCQkweDJjCQkweDIwCQkweDJjCkJRMjdY
WFhfUkVHX0RDQVAJMHgzYwkJMHgzYwkJMHgzYwkJMHgyZQkJMHgzYwkJMHgzYwkJMHgzYwkJ
LQkJMHgzYwpCUTI3WFhYX1JFR19BUAkJMHgyNAkJMHgyNAkJMHgyNAkJLQkJMHgyNAkJMHgy
NAkJMHgyNAkJLQkJLQ==
--------------024D8062C2B93B8D75CAB8AB--
